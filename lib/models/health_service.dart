import 'package:equatable/equatable.dart';

class HealthService extends Equatable {
  final String id;
  final String name;
  final String imageAsset;

  const HealthService({
    required this.id,
    required this.name,
    required this.imageAsset,
  });

  factory HealthService.fromJson(Map<String, dynamic> json) {
    return HealthService(
      id: json['id'] as String,
      name: json['name'] as String,
      imageAsset: json['imageAsset'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, imageAsset];
}
