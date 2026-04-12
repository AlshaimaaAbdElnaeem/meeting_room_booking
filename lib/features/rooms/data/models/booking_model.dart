import 'package:equatable/equatable.dart';

class BookingModel extends Equatable {
  final int id;
  final int roomId;
  final String date;
  final String startTime;
  final String endTime;
  final String userName;

  const BookingModel({
    required this.id,
    required this.roomId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.userName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as int,
      roomId: json['room_id'] as int,
      date: json['date'] as String? ?? '',
      startTime: _trimSeconds(json['start_time'] as String? ?? ''),
      endTime: _trimSeconds(json['end_time'] as String? ?? ''),
      userName: json['user_name'] as String? ?? '',
    );
  }

  static String _trimSeconds(String time) {
    if (time.length >= 5) return time.substring(0, 5);
    return time;
  }

  Map<String, dynamic> toJson() {
    return {
      'room_id': roomId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'user_name': userName,
    };
  }

  @override
  List<Object?> get props => [id, roomId, date, startTime, endTime, userName];
}