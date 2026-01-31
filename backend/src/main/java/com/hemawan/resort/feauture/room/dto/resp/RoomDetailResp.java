package com.hemawan.resort.feauture.room.dto.resp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RoomDetailResp {
    private Long id;
    private String name;
    private String detail;

    private BigDecimal pricePerNight;
    private BigDecimal discountedPricePerNight;
    private Double rating;
    private Integer maxGuests;

    private Integer roomSize;
    private Boolean isAvailable;
    private String imageUrl;
    private LocalDateTime createdAt;
}