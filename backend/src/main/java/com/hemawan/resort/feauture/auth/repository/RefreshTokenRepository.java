package com.hemawan.resort.feauture.auth.repository;

import com.hemawan.resort.feauture.auth.entity.RefreshTokenEntity;
import com.hemawan.resort.feauture.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RefreshTokenRepository extends JpaRepository<RefreshTokenEntity, Long> {

    Optional<RefreshTokenEntity> findByToken(String token);

    @Modifying
    @Query("UPDATE RefreshTokenEntity rt SET rt.revoked = true WHERE rt.user = :user")
    void revokeAllByUser(UserEntity user);

    @Modifying
    @Query("DELETE FROM RefreshTokenEntity rt WHERE rt.user = :user AND rt.revoked = true")
    void deleteRevokedTokensByUser(UserEntity user);
}
