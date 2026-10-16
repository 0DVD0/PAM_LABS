import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final String greeting;
  final String subtitle;
  final String imageAsset;

  const UserProfile({
    required this.name,
    required this.greeting,
    required this.subtitle,
    required this.imageAsset,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String,
      greeting: json['greeting'] as String,
      subtitle: json['subtitle'] as String,
      imageAsset: json['imageAsset'] as String,
    );
  }

  @override
  List<Object?> get props => [name, greeting, subtitle, imageAsset];
}
