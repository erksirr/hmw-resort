package com.hemawan.resort.feauture.room.repository;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.hemawan.resort.common.constant.QueryConstant;
import com.hemawan.resort.feauture.room.dto.resp.RoomDetailResp;
import com.hemawan.resort.feauture.room.dto.resp.RoomSearchResp;
import com.hemawan.resort.feauture.room.entity.RoomEntity;

@Repository
public interface RoomRepository extends JpaRepository<RoomEntity, Long> {
    @Query(value = QueryConstant.QUERY_ROOM_DETAIL, nativeQuery = true)
    RoomDetailResp findRoomDetailById(@Param("id") Long id);

    @Query(value = QueryConstant.QUERY_ROOM_SEARCH, nativeQuery = true)
    List<RoomSearchResp> searchRooms(
        @Param("query") String query,
        @Param("minPrice") BigDecimal minPrice,
        @Param("maxPrice") BigDecimal maxPrice,
        @Param("rating") Double rating,
        @Param("minGuests") Integer minGuests,
        @Param("maxGuests") Integer maxGuests,
        @Param("limit") Integer limit
    );
}
