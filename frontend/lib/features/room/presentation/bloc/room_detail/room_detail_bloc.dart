import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemawan_resort/features/room/data/repositories/room_repository.dart';
import 'room_detail_event.dart';
import 'room_detail_state.dart';

class RoomDetailBloc extends Bloc<RoomDetailEvent, RoomDetailState> {
  final RoomRepository repository;

  RoomDetailBloc({required this.repository}) : super(const RoomDetailState()) {
    on<LoadRoomDetail>(_onLoadRoomDetail);
    on<RefreshRoomDetail>(_onRefreshRoomDetail);
  }

  Future<void> _onLoadRoomDetail(
    LoadRoomDetail event,
    Emitter<RoomDetailState> emit,
  ) async {
    emit(state.copyWith(
      status: RoomDetailStatus.loading,
      roomId: event.roomId,
    ));

    try {
      final room = await repository.getRoomDetail(event.roomId);

      emit(state.copyWith(
        status: RoomDetailStatus.success,
        room: room,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RoomDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshRoomDetail(
    RefreshRoomDetail event,
    Emitter<RoomDetailState> emit,
  ) async {
    if (state.roomId == null) return;

    emit(state.copyWith(status: RoomDetailStatus.loading));

    try {
      final room = await repository.getRoomDetail(state.roomId!);

      emit(state.copyWith(
        status: RoomDetailStatus.success,
        room: room,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RoomDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}