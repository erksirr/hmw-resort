package com.hemawan.resort.feauture.auth.service;

import com.hemawan.resort.feauture.auth.dto.req.LoginReq;
import com.hemawan.resort.feauture.auth.dto.req.RefreshTokenReq;
import com.hemawan.resort.feauture.auth.dto.req.RegisterReq;
import com.hemawan.resort.feauture.auth.dto.resp.AuthResp;
import com.hemawan.resort.feauture.auth.entity.RefreshTokenEntity;
import com.hemawan.resort.feauture.auth.repository.RefreshTokenRepository;
import com.hemawan.resort.feauture.user.entity.Role;
import com.hemawan.resort.feauture.user.entity.UserEntity;
import com.hemawan.resort.feauture.user.repository.UserRepository;
import com.hemawan.resort.security.jwt.JwtService;
import com.hemawan.resort.security.service.CustomUserDetails;
import lombok.RequiredArgsConstructor;
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
                        request.getPassword()
                )
        );

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

        if (refreshToken.getRevoked()) {
            throw new RuntimeException("Refresh token has been revoked");
        }

        if (refreshToken.getExpiryDate().isBefore(Instant.now())) {
            throw new RuntimeException("Refresh token has expired");
        }

        UserEntity user = refreshToken.getUser();

        // Revoke old refresh token
        refreshToken.setRevoked(true);
        refreshTokenRepository.save(refreshToken);

        return generateAuthResponse(user);
    }

    @Transactional
    public void logout(RefreshTokenReq request) {
        RefreshTokenEntity refreshToken = refreshTokenRepository.findByToken(request.getRefreshToken())
                .orElseThrow(() -> new RuntimeException("Invalid refresh token"));

        refreshToken.setRevoked(true);
        refreshTokenRepository.save(refreshToken);
    }

    private AuthResp generateAuthResponse(UserEntity user) {
        CustomUserDetails userDetails = new CustomUserDetails(user);

        String accessToken = jwtService.generateAccessToken(userDetails);
        String refreshToken = jwtService.generateRefreshToken(userDetails);

        RefreshTokenEntity refreshTokenEntity = new RefreshTokenEntity();
        refreshTokenEntity.setUser(user);
        refreshTokenEntity.setToken(refreshToken);
        refreshTokenEntity.setExpiryDate(Instant.now().plusMillis(jwtService.getRefreshTokenExpiration()));
        refreshTokenEntity.setRevoked(false);
        refreshTokenRepository.save(refreshTokenEntity);

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
}
