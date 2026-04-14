import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_room_booking/features/rooms/data/models/booking_model.dart';

enum BookingStatus { initial, success, error }

class BookingsState extends Equatable {
  final List<BookingModel> bookings;
  final DateTime? selectedDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool isLoading;
  final String? errorMessage;
  final BookingStatus status; 


  const BookingsState({
    this.bookings = const [],
    this.selectedDate,
    this.startTime,
    this.endTime,
    this.isLoading = false,
    this.errorMessage,
    this.status = BookingStatus.initial,
  });

  BookingsState copyWith({
    List<BookingModel>? bookings,
    DateTime? selectedDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    BookingStatus? status,
    bool clearDateTime = false,

  }) {
    return BookingsState(
      bookings: bookings ?? this.bookings,
      selectedDate: clearDateTime ? null : selectedDate ?? this.selectedDate,
      startTime:clearDateTime ? null : startTime ?? this.startTime,
      endTime: clearDateTime ? null : endTime ?? this.endTime,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        bookings, selectedDate, startTime, endTime,
        isLoading, errorMessage, status,
      ];
}