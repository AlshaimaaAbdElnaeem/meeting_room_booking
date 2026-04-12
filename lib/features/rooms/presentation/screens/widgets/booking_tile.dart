import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking/core/theme/app_colors.dart';
import 'package:meeting_room_booking/core/theme/app_text_styles.dart';
import 'package:meeting_room_booking/features/rooms/data/models/booking_model.dart';

class BookingTile extends StatelessWidget {
  final BookingModel booking;
  final bool isConflict;

  const BookingTile({
    super.key,
    required this.booking,
    this.isConflict = false,
  });

  @override
  Widget build(BuildContext context) {
    final color      = isConflict ? AppColors.error   : AppColors.primary;
    final bgColor    = isConflict ? AppColors.errorLight : AppColors.primaryLight;
    final badgeLabel = isConflict ? 'Conflict'        : 'Confirmed';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Row(
        children: [
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.userName, style: AppTextStyles.h3),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 12.r, color: AppColors.textSecondary),
                    SizedBox(width: 4.w),
                    Text(booking.date, style: AppTextStyles.bodySmall),
                    SizedBox(width: 10.w),
                    Icon(Icons.access_time_outlined,
                        size: 12.r, color: AppColors.textSecondary),
                    SizedBox(width: 4.w),
                    Text(
                      '${booking.startTime} – ${booking.endTime}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              badgeLabel,
              style: AppTextStyles.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}