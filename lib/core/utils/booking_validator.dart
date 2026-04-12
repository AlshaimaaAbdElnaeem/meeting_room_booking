import 'package:meeting_room_booking/features/rooms/data/models/booking_model.dart';

class BookingValidator {
  static bool hasConflict({
    required List<BookingModel> existingBookings,
    required BookingModel newBooking,
  }) {
    final newStart = _toMinutes(newBooking.startTime);
    final newEnd = _toMinutes(newBooking.endTime);

    if (newEnd <= newStart) return true;

    return existingBookings.any((booking) {
      if (booking.date != newBooking.date) return false;

      final existStart = _toMinutes(booking.startTime);
      final existEnd = _toMinutes(booking.endTime);

      return newStart < existEnd && newEnd > existStart;
    });
  }

  static int _toMinutes(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return -1;

    final h = int.tryParse(parts[0]) ?? -1;
    final m = int.tryParse(parts[1]) ?? -1;

    if (h < 0 || m < 0) return -1;

    return h * 60 + m;
  }
}