import 'package:dartz/dartz.dart';
import 'package:meeting_room_booking/core/errors/failure.dart';
import 'package:meeting_room_booking/features/rooms/data/models/booking_model.dart';
import 'package:meeting_room_booking/features/rooms/data/models/room_model.dart';

abstract class RoomRepositories {
  Future<Either<Failure, List<RoomModel>>> getRooms();
  Future<Either<Failure, List<BookingModel>>> getBookings(int roomId);
  Future<Either<Failure, BookingModel>> createBooking(BookingModel booking);

}