package com.hemawan.resort.feauture.room.controller;

import com.hemawan.resort.common.resp.SuccessResponse;
import com.hemawan.resort.feauture.room.dto.req.RoomBookingReq;
import com.hemawan.resort.feauture.room.dto.req.RoomDetailReq;
import com.hemawan.resort.feauture.room.dto.req.RoomSearchReq;
import com.hemawan.resort.feauture.room.dto.resp.RoomDetailResp;
import com.hemawan.resort.feauture.room.dto.resp.RoomSearchResp;
import com.hemawan.resort.feauture.room.service.RoomService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/room")
@RequiredArgsConstructor
public class RoomController {

    private final RoomService roomService;

    @PostMapping("/detail")
    public ResponseEntity<RoomDetailResp> getRoomDetail(@RequestBody RoomDetailReq req) {
        return ResponseEntity.ok(roomService.getRoomDetail(req));
    }

    @PostMapping("/search")
    public ResponseEntity<List<RoomSearchResp>> searchRooms(@RequestBody RoomSearchReq req) {
        return ResponseEntity.ok(roomService.searchRooms(req));
    }

    @PostMapping("/booking")
    public ResponseEntity<SuccessResponse> bookingRoom(@RequestBody RoomBookingReq req) {
        return ResponseEntity.ok(roomService.bookingRoom(req));
    }

}