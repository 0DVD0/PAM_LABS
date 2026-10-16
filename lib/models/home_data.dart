import 'package:equatable/equatable.dart';

import 'appointment_summary.dart';
import 'doctor.dart';
import 'health_service.dart';
import 'user_profile.dart';

class HomeData extends Equatable {
  final UserProfile user;
  final bool hasUnreadNotifications;
  final String searchHint;
  final AppointmentSummary appointment;
  final List<HealthService> healthServices;
  final List<Doctor> nearbyDoctors;

  const HomeData({
    required this.user,
    required this.hasUnreadNotifications,
    required this.searchHint,
    required this.appointment,
    required this.healthServices,
    required this.nearbyDoctors,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    final notifications = json['notifications'] as Map<String, dynamic>;
    final search = json['search'] as Map<String, dynamic>;

    return HomeData(
      user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
      hasUnreadNotifications: notifications['hasUnread'] as bool,
      searchHint: search['hint'] as String,
      appointment: AppointmentSummary.fromJson(
        json['appointment'] as Map<String, dynamic>,
      ),
      healthServices: (json['healthServices'] as List<dynamic>)
          .map((item) => HealthService.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      nearbyDoctors: (json['nearbyDoctors'] as List<dynamic>)
          .map((item) => Doctor.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  @override
  List<Object?> get props => [
    user,
    hasUnreadNotifications,
    searchHint,
    appointment,
    healthServices,
    nearbyDoctors,
  ];
}
