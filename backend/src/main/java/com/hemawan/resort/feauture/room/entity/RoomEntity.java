package com.hemawan.resort.feauture.room.entity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "room_detail")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RoomEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "name")
    private String name;
    
    @Column(name = "detail")
    private String detail;
    
    @Column(name = "price_per_night")
    private BigDecimal pricePerNight;
    
    @Column(name = "discounted_price_per_night")
    private BigDecimal discountedPricePerNight;
    
    @Column(name = "rating")
    private Double rating;
    
    @Column(name = "max_guests")
    private Integer maxGuests;
    
    @Column(name = "room_size")
    private Integer roomSize;
    
    @Column(name = "is_available")
    private Boolean isAvailable ;
    
    @Column(name = "image_url", length = 500)
    private String imageUrl;
    
    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}