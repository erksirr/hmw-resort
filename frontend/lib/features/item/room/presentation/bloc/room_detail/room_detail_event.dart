import 'package:equatable/equatable.dart';

abstract class RoomDetailEvent extends Equatable {
  const RoomDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadRoomDetail extends RoomDetailEvent {
  final int roomId;

  const LoadRoomDetail(this.roomId);

  @override
  List<Object?> get props => [roomId];
}

class RefreshRoomDetail extends RoomDetailEvent {
  const RefreshRoomDetail();
}
