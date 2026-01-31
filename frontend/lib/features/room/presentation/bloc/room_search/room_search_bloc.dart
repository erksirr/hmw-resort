import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemawan_resort/features/room/data/repositories/room_repository.dart';
import 'room_search_event.dart';
import 'room_search_state.dart';

class RoomSearchBloc extends Bloc<RoomSearchEvent, RoomSearchState> {
  final RoomRepository repository;

  RoomSearchBloc({required this.repository}) : super(const RoomSearchState()) {
    on<SearchRooms>(_onSearchRooms);
  }

  Future<void> _onSearchRooms(
    SearchRooms event,
    Emitter<RoomSearchState> emit,
  ) async {
    final params = event.params ?? state.params;
    emit(state.copyWith(status: RoomSearchStatus.loading, params: params));

    try {
      final rooms = await repository.getSearchRooms(params: params);
      emit(state.copyWith(status: RoomSearchStatus.success, rooms: rooms));
    } catch (e) {
      emit(state.copyWith(
        status: RoomSearchStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}