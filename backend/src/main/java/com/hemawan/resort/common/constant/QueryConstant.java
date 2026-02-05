package com.hemawan.resort.common.constant;

public class QueryConstant {
    public static final String QUERY_ROOM_DETAIL = """
        select id, name, detail, price_per_night AS pricePerNight, discounted_price_per_night AS discountedPricePerNight,
        rating, max_guests AS maxGuests, room_size AS roomSize, is_available AS isAvailable,
        image_url AS imageUrl, created_at AS createdAt
        from room_detail
        where id = :id""";

    public static final String QUERY_ROOM_SEARCH =
        """
        select id, name, price_per_night AS pricePerNight, image_url AS imageUrl
        from room_detail
        where is_available = true
        AND (:query IS NULL OR LOWER(name) LIKE LOWER(CONCAT('%', :query, '%')) OR LOWER(detail) LIKE LOWER(CONCAT('%', :query, '%')))
        AND (CAST(:minPrice AS NUMERIC) IS NULL OR price_per_night >= :minPrice)
        AND (CAST(:maxPrice AS NUMERIC) IS NULL OR price_per_night <= :maxPrice)
        AND (CAST(:rating AS DOUBLE PRECISION) IS NULL OR rating >= :rating)
        AND (CAST(:minGuests AS INTEGER) IS NULL OR max_guests >= :minGuests)
        AND (CAST(:maxGuests AS INTEGER) IS NULL OR max_guests <= :maxGuests)
        ORDER BY created_at DESC
        """;
}