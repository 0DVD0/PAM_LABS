import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String address;
  final int distanceMeters;
  final double consultationPrice;
  final String listImageAsset;
  final String profileImageAsset;
  final bool isFavorite;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.address,
    required this.distanceMeters,
    required this.consultationPrice,
    required this.listImageAsset,
    required this.profileImageAsset,
    required this.isFavorite,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      address: json['address'] as String,
      distanceMeters: json['distanceMeters'] as int,
      consultationPrice: (json['consultationPrice'] as num).toDouble(),
      listImageAsset: json['listImageAsset'] as String,
      profileImageAsset: json['profileImageAsset'] as String,
      isFavorite: json['isFavorite'] as bool,
    );
  }

  Doctor copyWith({bool? isFavorite}) {
    return Doctor(
      id: id,
      name: name,
      specialty: specialty,
      address: address,
      distanceMeters: distanceMeters,
      consultationPrice: consultationPrice,
      listImageAsset: listImageAsset,
      profileImageAsset: profileImageAsset,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    specialty,
    address,
    distanceMeters,
    consultationPrice,
    listImageAsset,
    profileImageAsset,
    isFavorite,
  ];
}
