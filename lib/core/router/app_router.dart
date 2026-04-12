
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking/features/rooms/data/models/room_model.dart';
import 'package:meeting_room_booking/features/rooms/presentation/screens/booking_screen.dart';
import 'package:meeting_room_booking/features/rooms/presentation/screens/rooms_screen.dart';

class AppRouter {
  static const String rooms   = '/';
  static const String booking = '/booking';

  static final GoRouter router = GoRouter(
    initialLocation: rooms,
    routes: [
      GoRoute(
        path: rooms,
        builder: (context, state) => const RoomsScreen(),
      ),
      GoRoute(
        path: booking,
        builder: (context, state) {
          final room = state.extra as RoomModel;
          return BookingScreen(room: room);
        },
      ),
    ],
  );
}