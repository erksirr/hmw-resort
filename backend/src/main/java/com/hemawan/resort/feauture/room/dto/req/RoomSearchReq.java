package com.hemawan.resort.feauture.room.dto.req;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class RoomSearchReq{
    private BigDecimal minPrice;
    private BigDecimal maxPrice;
    private Double rating;
    private Integer minGuests;
    private Integer maxGuests;
    private Integer limit = 20;
    private String sortBy = "createdAt"; // createdAt, price, rating
    private String query;
}