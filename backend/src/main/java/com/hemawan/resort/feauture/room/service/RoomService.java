package com.hemawan.resort.feauture.room.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hemawan.resort.common.resp.SuccessResponse;
import com.hemawan.resort.feauture.room.dto.req.RoomBookingReq;
import com.hemawan.resort.feauture.room.dto.req.RoomDetailReq;
import com.hemawan.resort.feauture.room.dto.req.RoomSearchReq;
import com.hemawan.resort.feauture.room.dto.resp.RoomDetailResp;
import com.hemawan.resort.feauture.room.dto.resp.RoomSearchResp;
import com.hemawan.resort.feauture.room.repository.RoomRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RoomService {
        private final RoomRepository roomRepository;

        public RoomDetailResp getRoomDetail(RoomDetailReq req) {
                return roomRepository.findRoomDetailById(req.getId())
                        .orElseThrow(() -> new RuntimeException("Room not found with id: " + req.getId()));
        }

        public List<RoomSearchResp> searchRooms(RoomSearchReq req) {
                return roomRepository.searchRooms(
                        req.getMinPrice(),
                        req.getMaxPrice(),
                        req.getRating(),
                        req.getMinGuests(),
                        req.getMaxGuests(),
                        req.getLimit()
                );
        }

        public SuccessResponse bookingRoom(RoomBookingReq req) {
                return new SuccessResponse();
        }
}
