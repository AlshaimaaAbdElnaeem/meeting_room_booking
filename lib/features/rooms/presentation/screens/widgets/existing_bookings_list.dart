import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking/core/theme/app_colors.dart';
import 'package:meeting_room_booking/core/theme/app_text_styles.dart';
import 'package:meeting_room_booking/features/rooms/data/models/booking_model.dart';
import 'booking_tile.dart';

class ExistingBookingsList extends StatelessWidget {
  final List<BookingModel> bookings;

  const ExistingBookingsList({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(count: bookings.length),
        SizedBox(height: 12.h),
        bookings.isEmpty ? _EmptyState() : _BookingsList(bookings: bookings),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final int count;

  const _Header({required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Existing Bookings', style: AppTextStyles.h3),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$count',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          children: [
            Icon(Icons.event_available, size: 48.r, color: AppColors.textHint),
            SizedBox(height: 8.h),
            Text('No bookings yet', style: AppTextStyles.bodySecondary),
          ],
        ),
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  final List<BookingModel> bookings;

  const _BookingsList({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookings.map((b) {
        return BookingTile(
          booking: b,
        );
      }).toList(),
    );
  }
}