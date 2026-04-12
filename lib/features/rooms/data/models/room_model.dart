import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
	final int? id;
	final String? status;
	final dynamic sort;
	final String? userCreated;
	final DateTime? dateCreated;
	final dynamic userUpdated;
	final dynamic dateUpdated;
	final String? name;
	final num? capacity;

	const RoomModel({
		this.id, 
		this.status, 
		this.sort, 
		this.userCreated, 
		this.dateCreated, 
		this.userUpdated, 
		this.dateUpdated, 
		this.name, 
		this.capacity, 
	});

	factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
				id: json['id'] as int?,
				status: json['status'] as String?,
				sort: json['sort'] as dynamic,
				userCreated: json['user_created'] as String?,
				dateCreated: json['date_created'] == null
						? null
						: DateTime.parse(json['date_created'] as String),
				userUpdated: json['user_updated'] as dynamic,
				dateUpdated: json['date_updated'] as dynamic,
				name: json['name'] as String?,
				capacity: json['capacity'] as num?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'status': status,
				'sort': sort,
				'user_created': userCreated,
				'date_created': dateCreated?.toIso8601String(),
				'user_updated': userUpdated,
				'date_updated': dateUpdated,
				'name': name,
				'capacity': capacity,
			};

	@override
	List<Object?> get props {
		return [
				id,
				status,
				sort,
				userCreated,
				dateCreated,
				userUpdated,
				dateUpdated,
				name,
				capacity,
		];
	}
}
