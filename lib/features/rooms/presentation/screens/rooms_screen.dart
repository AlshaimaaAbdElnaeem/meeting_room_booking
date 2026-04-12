import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking/core/theme/app_colors.dart';
import 'package:meeting_room_booking/core/theme/app_text_styles.dart';
import 'package:meeting_room_booking/core/widgets/error_widget.dart';
import 'package:meeting_room_booking/core/widgets/loading_widget.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/rooms_cubit/rooms_cubit.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/rooms_cubit/rooms_state.dart';
import 'package:meeting_room_booking/features/rooms/presentation/screens/booking_screen.dart';
import 'package:meeting_room_booking/features/rooms/presentation/screens/widgets/room_card.dart';
import 'package:meeting_room_booking/injection_container.dart';


class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RoomsCubit>()..getRooms(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Meeting Rooms', style: AppTextStyles.h2),
          backgroundColor: AppColors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(height: 1, color: AppColors.divider),
          ),
        ),
        body: BlocBuilder<RoomsCubit, RoomsState>(
          builder: (context, state) {
            if (state is RoomsLoading) {
              return const LoadingWidget();
            }

            if (state is RoomsFailure) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () => context.read<RoomsCubit>().getRooms(),
              );
            }

            if (state is RoomsSuccess) {
              return _RoomsList(state: state);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _RoomsList extends StatelessWidget {
  final RoomsSuccess state;

  const _RoomsList({required this.state});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<RoomsCubit>().getRooms(),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        itemCount: state.rooms.length,
        itemBuilder: (context, index) {
          final room = state.rooms[index];
          return RoomCard(
            room: room,
            onBookPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingScreen(room: room),
                ),
              );
            },
          );
        },
      ),
    );
  }
}