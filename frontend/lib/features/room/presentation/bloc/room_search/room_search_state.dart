import 'package:equatable/equatable.dart';
import 'package:hemawan_resort/features/room/data/models/room_model.dart';
import 'package:hemawan_resort/features/room/data/models/room_search_params.dart';

enum RoomSearchStatus { initial, loading, success, failure }

class RoomSearchState extends Equatable {
  final RoomSearchStatus status;
  final List<RoomModel> rooms;
  final RoomSearchParams params;
  final String? errorMessage;

  const RoomSearchState({
    this.status = RoomSearchStatus.initial,
    this.rooms = const [],
    this.params = const RoomSearchParams(),
    this.errorMessage,
  });

  RoomSearchState copyWith({
    RoomSearchStatus? status,
    List<RoomModel>? rooms,
    RoomSearchParams? params,
    String? errorMessage,
  }) {
    return RoomSearchState(
      status: status ?? this.status,
      rooms: rooms ?? this.rooms,
      params: params ?? this.params,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, rooms, params, errorMessage];
}