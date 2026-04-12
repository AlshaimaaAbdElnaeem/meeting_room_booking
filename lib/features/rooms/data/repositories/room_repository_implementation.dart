import 'package:dartz/dartz.dart';
import 'package:meeting_room_booking/core/errors/failure.dart';
import 'package:meeting_room_booking/core/networks/api_service.dart';
import 'package:meeting_room_booking/core/networks/end_points.dart';
import 'package:meeting_room_booking/features/rooms/data/repositories/room_repository.dart';
import '../models/booking_model.dart';
import '../models/room_model.dart';

class RoomsRepositoryImplementation extends RoomRepositories {
  final ApiService apiService;

  RoomsRepositoryImplementation({required this.apiService});

  @override
  Future<Either<Failure, List<RoomModel>>> getRooms() async {
    try {
      final response = await apiService.get(endPoint: EndPoints.rooms);
      final List data = response['data'] as List;
      return Right(data.map((e) => RoomModel.fromJson(e)).toList());
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> getBookings(int roomId) async {
    try {
      final response = await apiService.get(
        endPoint: EndPoints.bookings,
        queryParameters: {'filter[room_id][_eq]': roomId},
      );
      final List data = response['data'] as List;
      return Right(data.map((e) => BookingModel.fromJson(e)).toList());
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, BookingModel>> createBooking(
      BookingModel booking) async {
    try {
      final response = await apiService.post(
        endPoint: EndPoints.bookings,
        data: booking.toJson(),
      );
      return Right(BookingModel.fromJson(response['data']));
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }
}