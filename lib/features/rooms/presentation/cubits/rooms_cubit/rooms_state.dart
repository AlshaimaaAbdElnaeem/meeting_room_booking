import 'package:equatable/equatable.dart';
import 'package:meeting_room_booking/features/rooms/data/models/room_model.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object?> get props => [];
}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsSuccess extends RoomsState {
  final List<RoomModel> rooms;
  const RoomsSuccess({required this.rooms});

  @override
  List<Object?> get props => [rooms];
}

class RoomsFailure extends RoomsState {
  final String message;
  const RoomsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}