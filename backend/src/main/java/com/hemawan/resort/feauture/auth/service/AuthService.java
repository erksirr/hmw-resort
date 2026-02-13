package com.hemawan.resort.feauture.auth.service;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import com.hemawan.resort.feauture.auth.dto.req.LoginReq;
import com.hemawan.resort.feauture.auth.dto.req.LoginWithGoogleReq;
import com.hemawan.resort.feauture.auth.dto.req.RefreshTokenReq;
import com.hemawan.resort.feauture.auth.dto.req.RegisterReq;
import com.hemawan.resort.feauture.auth.dto.resp.AuthResp;
import com.hemawan.resort.feauture.auth.entity.RefreshTokenEntity;
import com.hemawan.resort.feauture.auth.repository.RefreshTokenRepository;
import com.hemawan.resort.feauture.user.entity.AuthProvider;
import com.hemawan.resort.feauture.user.entity.Role;
import com.hemawan.resort.feauture.user.entity.UserEntity;
import com.hemawan.resort.feauture.user.repository.UserRepository;
import com.hemawan.resort.security.jwt.JwtService;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import static com.hemawan.resort.common.constant.ErrorConstant.*;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    @Transactional
    public AuthResp register(RegisterReq request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        UserEntity user = new UserEntity();
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole(Role.USER);
        user.setIsActive(true);

        user = userRepository.save(user);

        return generateAuthResponse(user);
    }

    @Transactional
    public AuthResp login(LoginReq request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()));

        UserEntity user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Revoke old refresh tokens
        refreshTokenRepository.revokeAllByUser(user);

        return generateAuthResponse(user);
    }

    @Transactional
    public AuthResp refreshToken(RefreshTokenReq request) {
        RefreshTokenEntity refreshToken = refreshTokenRepository.findByToken(request.getRefreshToken())
                .orElseThrow(() -> new RuntimeException("Invalid refresh token"));

        System.out.println("=== REFRESH TOKEN ===");
        System.out.println("Token ID: " + refreshToken.getId());
        System.out.println("Revoked status: " + refreshToken.getRevoked());

        if (Boolean.TRUE.equals(refreshToken.getRevoked())) {
            System.out.println("ERROR: Token already revoked!");
            throw new RuntimeException("Refresh token has been revoked");
        }

        if (refreshToken.getExpiryDate().isBefore(Instant.now())) {
            System.out.println("ERROR: Token expired!");
            throw new RuntimeException("Refresh token has expired");
        }

        UserEntity user = refreshToken.getUser();

        // Revoke old refresh token
        System.out.println("Revoking old token...");
        refreshToken.setRevoked(true);
        refreshTokenRepository.save(refreshToken);
        System.out.println("Token revoked: " + refreshToken.getRevoked());
        System.out.println("==========================");

        return generateAuthResponse(user);
    }

    @Transactional
    public void logout(RefreshTokenReq request) {
        RefreshTokenEntity refreshToken = refreshTokenRepository.findByToken(request.getRefreshToken())
                .orElseThrow(() -> new RuntimeException("Invalid refresh token"));

        System.out.println("=== LOGOUT ===");
        System.out.println("Token ID: " + refreshToken.getId());
        System.out.println("User: " + refreshToken.getUser().getEmail());
        System.out.println("Revoked BEFORE: " + refreshToken.getRevoked());

        refreshToken.setRevoked(true);
        refreshTokenRepository.save(refreshToken);

        System.out.println("Revoked AFTER: " + refreshToken.getRevoked());
        System.out.println("===================");
    }

    private AuthResp generateAuthResponse(UserEntity user) {
        String accessToken = jwtService.generateAccessToken(user);
        String refreshToken = jwtService.generateRefreshToken(user);

        RefreshTokenEntity refreshTokenEntity = new RefreshTokenEntity();
        refreshTokenEntity.setUser(user);
        refreshTokenEntity.setToken(refreshToken);
        refreshTokenEntity.setExpiryDate(Instant.now().plusMillis(jwtService.getRefreshTokenExpiration()));
        refreshTokenEntity.setRevoked(false);
        refreshTokenRepository.save(refreshTokenEntity);

        System.out.println("=== NEW TOKEN CREATED ===");
        System.out.println("Token ID: " + refreshTokenEntity.getId());
        System.out.println("User: " + user.getEmail());
        System.out.println("Revoked: " + refreshTokenEntity.getRevoked());
        System.out.println("=========================");

        AuthResp authResp = new AuthResp();
        authResp.setAccessToken(accessToken);
        authResp.setRefreshToken(refreshToken);
        authResp.setTokenType("Bearer");
        authResp.setExpiresIn(jwtService.getAccessTokenExpiration() / 1000);

        AuthResp.UserInfo userInfo = new AuthResp.UserInfo();
        userInfo.setId(user.getId());
        userInfo.setEmail(user.getEmail());
        userInfo.setFirstName(user.getFirstName());
        userInfo.setLastName(user.getLastName());
        userInfo.setRole(user.getRole().name());

        authResp.setUser(userInfo);

        return authResp;
    }

    @Transactional
    public AuthResp loginWithGoogle(LoginWithGoogleReq request) {
        try {
            // Verify Firebase idToken
            FirebaseToken decodedToken = FirebaseAuth.getInstance()
                    .verifyIdToken(request.getIdToken());

            String email = decodedToken.getEmail();
            String name = decodedToken.getName();
            String uid = decodedToken.getUid();

            System.out.println("Decoded Firebase Token: " + decodedToken);
            System.out.println("Email: " + email + ", Name: " + name + ", UID: " + uid);
            // check user in PostgreSQL
            UserEntity user = userRepository.findByEmail(email)
                    .orElseGet(() -> {
                        UserEntity newUser = UserEntity.builder()
                                .email(email)
                                .firstName(name)
                                .authProvider(AuthProvider.GOOGLE)
                                .firebaseUid(uid)
                                .role(Role.USER)
                                .isActive(true)
                                .build();
                        return userRepository.save(newUser);
                    });

            // Revoke old refresh tokens
            refreshTokenRepository.revokeAllByUser(user);

            // Generate JWT token
            return generateAuthResponse(user);

        } catch (Exception e) {
            throw new RuntimeException("Failed to verify Firebase token: " + e.getMessage());
        }
    }
}
