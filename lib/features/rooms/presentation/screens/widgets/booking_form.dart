import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking/core/theme/app_colors.dart';
import 'package:meeting_room_booking/core/theme/app_text_styles.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/bookings_cubit/bookings_cubit.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/bookings_cubit/bookings_state.dart';
import 'picker_field.dart';

class BookingForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final VoidCallback onSubmit;

  const BookingForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingsCubit>();

    return BlocBuilder<BookingsCubit, BookingsState>(
      buildWhen: (prev, curr) =>
          prev.selectedDate != curr.selectedDate ||
          prev.startTime != curr.startTime ||
          prev.endTime != curr.endTime ||
          prev.isLoading != curr.isLoading ||
          prev.errorMessage != curr.errorMessage ||
          prev.bookings != curr.bookings,

      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Booking', style: AppTextStyles.h2),
                SizedBox(height: 20.h),

                // ---------------- NAME ----------------
                Text('Your name', style: AppTextStyles.bodySecondary),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Name is required' : null,
                ),

                SizedBox(height: 16.h),

                // ---------------- DATE ----------------
                Text('Date', style: AppTextStyles.bodySecondary),
                SizedBox(height: 6.h),
                PickerField(
                  value: state.selectedDate == null
                      ? null
                      : "${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}",
                  hint: 'Select date',
                  icon: Icons.calendar_today_outlined,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: state.selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    if (picked != null) {
                      cubit.setDate(picked);
                    }
                  },
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: PickerField(
                        value: state.startTime?.format(context),
                        hint: 'Start time',
                        icon: Icons.access_time,
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime:
                                state.startTime ?? TimeOfDay.now(),
                          );

                          if (picked != null) {
                            cubit.setStartTime(picked);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: PickerField(
                        value: state.endTime?.format(context),
                        hint: 'End time',
                        icon: Icons.access_time,
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime:
                                state.endTime ??
                                state.startTime ??
                                TimeOfDay.now(),
                          );

                          if (picked != null) {
                            cubit.setEndTime(picked);
                          }
                        },
                      ),
                    ),
                  ],
                ),

                // ---------------- ERROR ----------------
                if (state.errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),

                SizedBox(height: 24.h),

                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : onSubmit,
                    child: state.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Confirm Booking',
                            style: AppTextStyles.button,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}