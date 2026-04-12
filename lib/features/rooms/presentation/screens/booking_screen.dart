import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking/core/theme/app_colors.dart';
import 'package:meeting_room_booking/core/theme/app_text_styles.dart';
import 'package:meeting_room_booking/core/widgets/error_widget.dart';
import 'package:meeting_room_booking/core/widgets/loading_widget.dart';
import 'package:meeting_room_booking/features/rooms/data/models/room_model.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/bookings_cubit/bookings_cubit.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/bookings_cubit/bookings_state.dart';
import 'package:meeting_room_booking/features/rooms/presentation/screens/widgets/booking_form.dart';
import 'package:meeting_room_booking/features/rooms/presentation/screens/widgets/existing_bookings_list.dart';
import 'package:meeting_room_booking/injection_container.dart';

class BookingScreen extends StatelessWidget {
  final RoomModel room;

  const BookingScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookingsCubit>()..getBookings(room.id!),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(room.name!, style: AppTextStyles.h2),
          backgroundColor: AppColors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(height: 1, color: AppColors.divider),
          ),
        ),
        body: BlocConsumer<BookingsCubit, BookingsState>(
          listener: _listener,
          builder: _builder,
        ),
      ),
    );
  }

 void _listener(BuildContext context, BookingsState state) {
  final cubit = context.read<BookingsCubit>();

  // Booking success
  if (state.createdBooking != null) {
    _showSnackBar(
      context,
      'Booking confirmed!',
      AppColors.primary,
    );

    cubit.getBookings(room.id!);

   
    cubit.clearStatus();
  }

  // Error handling
  if (state.errorMessage != null) {
    _showSnackBar(
      context,
      state.errorMessage!,
      AppColors.error,
    );

    cubit.clearStatus();
  }
}

  Widget _builder(BuildContext context, BookingsState state) {
   if (state.isLoading) return const LoadingWidget();

  if (state.errorMessage != null) {
    return AppErrorWidget(
      message: state.errorMessage!,
      onRetry: () => context.read<BookingsCubit>().getBookings(room.id!),
    );
  }

  return _BookingBody(room: room);
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}

class _BookingBody extends StatefulWidget {
  final RoomModel room;

  const _BookingBody({required this.room});

  @override
  State<_BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<_BookingBody> {
final TextEditingController nameController = TextEditingController();

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
@override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingsCubit>();
    final state = context.watch<BookingsCubit>().state;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        BookingForm(
  formKey: formKey,
  nameController: nameController,
  onSubmit: () {
    if (!formKey.currentState!.validate()) return;

    cubit.submitBooking(
      userName: nameController.text.trim(),
      roomId: widget.room.id!,
    );
  },
),

          SizedBox(height: 24.h),

          ExistingBookingsList(
            bookings: state.bookings,
          ),
        ],
      ),
    );
  }
}