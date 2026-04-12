import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meeting_room_booking/core/networks/dio_consumer.dart';
import 'package:meeting_room_booking/core/networks/api_service.dart';
import 'package:meeting_room_booking/features/rooms/data/repositories/room_repository.dart';
import 'package:meeting_room_booking/features/rooms/data/repositories/room_repository_implementation.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/bookings_cubit/bookings_cubit.dart';
import 'package:meeting_room_booking/features/rooms/presentation/cubits/rooms_cubit/rooms_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // ApiService
  sl.registerLazySingleton<ApiService>(
    () => DioConsumer(sl<Dio>()),
  );

  // Repository
  sl.registerLazySingleton<RoomRepositories>(
    () => RoomsRepositoryImplementation(apiService: sl<ApiService>()),
  );

  // Cubits
  sl.registerFactory<RoomsCubit>(
    () => RoomsCubit(roomRepositories: sl<RoomRepositories>()),
  );
  sl.registerFactory<BookingsCubit>(
    () => BookingsCubit(roomRepository: sl<RoomRepositories>()),
  );
}