import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meeting_room_booking/core/utils/booking_validator.dart';
import 'package:meeting_room_booking/features/rooms/data/models/booking_model.dart';
import 'package:meeting_room_booking/features/rooms/data/repositories/room_repository.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/bookings_cubit/bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  final RoomRepositories roomRepository;

  BookingsCubit({required this.roomRepository}) : super(const BookingsState());

  // ---------------- GET BOOKINGS ----------------
  Future<void> getBookings(int roomId) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await roomRepository.getBookings(roomId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (bookings) => emit(state.copyWith(
        isLoading: false,
        bookings: bookings,
      )),
    );
  }

  // ---------------- DATE/TIME ----------------
  void setDate(DateTime date) {
    emit(state.copyWith(selectedDate: date, clearError: true));
  }

  void setStartTime(TimeOfDay time) {
    emit(state.copyWith(startTime: time, clearError: true));
  }

  void setEndTime(TimeOfDay time) {
    emit(state.copyWith(endTime: time, clearError: true));
  }

  // ---------------- FORMATTING ----------------
  String _fmt(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  // ---------------- VALIDATION ----------------
String? validateFields(String userName, BookingModel booking) {
  if (userName.trim().isEmpty) return 'Name is required';
  if (state.selectedDate == null) return 'Select date';
  if (state.startTime == null) return 'Select start time';
  if (state.endTime == null) return 'Select end time';

  final hasConflict = BookingValidator.hasConflict(
    existingBookings: state.bookings,
    newBooking: booking,
  );

  if (hasConflict) {
    return 'This time slot is already booked!';
  }

  return null;
}
Future<void> submitBooking({
  required String userName,
  required int roomId,
}) async {
  if (userName.trim().isEmpty) {
    emit(state.copyWith(errorMessage: 'Name is required'));
    return;
  }

  if (state.selectedDate == null ||
      state.startTime == null ||
      state.endTime == null) {
    emit(state.copyWith(errorMessage: 'Please complete all fields'));
    return;
  }
  await getBookings(roomId);

  final booking = BookingModel(
    id: 0,
    roomId: roomId,
    date: DateFormat('yyyy-MM-dd').format(state.selectedDate!),
    startTime: _fmt(state.startTime!),
    endTime: _fmt(state.endTime!),
    userName: userName.trim(),
  );

  final hasConflict = BookingValidator.hasConflict(
    existingBookings: state.bookings,
    newBooking: booking,
  );

  if (hasConflict) {
    emit(state.copyWith(errorMessage: 'This time slot is already booked!'));
    return;
  }

  await _createBooking(booking);
}
  // ---------------- CREATE ----------------
  Future<void> _createBooking(BookingModel booking) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await roomRepository.createBooking(booking);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (newBooking) {
        emit(state.copyWith(
          isLoading: false,
          bookings: [...state.bookings, newBooking],
          createdBooking: newBooking,
        ));
      },
    );
  }

  // ---------------- CLEAR ----------------
  void clearStatus() {
    emit(state.copyWith(clearError: true, clearCreated: true));
  }
}