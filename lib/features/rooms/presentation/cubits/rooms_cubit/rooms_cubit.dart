import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/features/rooms/data/repositories/room_repository.dart';
import 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final RoomRepositories roomRepositories;

  RoomsCubit({required this.roomRepositories}) : super(RoomsInitial());

  Future<void> getRooms() async {
    emit(RoomsLoading());
    final result = await roomRepositories.getRooms();
    result.fold(
      (failure) => emit(RoomsFailure(message: failure.message)),
      (rooms) => emit(RoomsSuccess(rooms: rooms)),
    );
  }
}