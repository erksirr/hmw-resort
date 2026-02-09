import 'package:equatable/equatable.dart';
import 'package:hemawan_resort/features/item/room/data/models/room_search_params.dart';

sealed class RoomSearchEvent extends Equatable {
  const RoomSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchRooms extends RoomSearchEvent {
  final RoomSearchParams? params;

  const SearchRooms([this.params]);

  @override
  List<Object?> get props => [params];
}