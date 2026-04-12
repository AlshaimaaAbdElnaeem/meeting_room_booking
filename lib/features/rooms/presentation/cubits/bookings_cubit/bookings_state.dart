import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_room_booking/features/rooms/data/models/booking_model.dart';

class BookingsState extends Equatable {
  final List<BookingModel> bookings;

  final DateTime? selectedDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  final bool isLoading;
  final String? errorMessage;
  final BookingModel? createdBooking;

  const BookingsState({
    this.bookings = const [],
    this.selectedDate,
    this.startTime,
    this.endTime,
    this.isLoading = false,
    this.errorMessage,
    this.createdBooking,
  });

  BookingsState copyWith({
    List<BookingModel>? bookings,
    DateTime? selectedDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isLoading,
    String? errorMessage,
    BookingModel? createdBooking,
    bool clearError = false,
    bool clearCreated = false,
  }) {
    return BookingsState(
      bookings: bookings ?? this.bookings,
      selectedDate: selectedDate ?? this.selectedDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      createdBooking: clearCreated ? null : createdBooking ?? this.createdBooking,
    );
  }

  @override
  List<Object?> get props => [
        bookings,
        selectedDate,
        startTime,
        endTime,
        isLoading,
        errorMessage,
        createdBooking,
      ];
}