import 'package:equatable/equatable.dart';
import 'package:hemawan_resort/features/room/data/models/room_model.dart';

enum RoomDetailStatus { initial, loading, success, failure }

class RoomDetailState extends Equatable {
  final RoomDetailStatus status;
  final RoomModel? room;
  final int? roomId;
  final String? errorMessage;

  const RoomDetailState({
    this.status = RoomDetailStatus.initial,
    this.room,
    this.roomId,
    this.errorMessage,
  });

  RoomDetailState copyWith({
    RoomDetailStatus? status,
    RoomModel? room,
    int? roomId,
    String? errorMessage,
  }) {
    return RoomDetailState(
      status: status ?? this.status,
      room: room ?? this.room,
      roomId: roomId ?? this.roomId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, room, roomId, errorMessage];
}