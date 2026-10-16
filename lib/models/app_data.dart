import 'package:equatable/equatable.dart';

import 'appointment_details.dart';
import 'home_data.dart';

class AppData extends Equatable {
  final HomeData home;
  final AppointmentDetails appointmentDetails;

  const AppData({required this.home, required this.appointmentDetails});

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      home: HomeData.fromJson(json['homeScreen'] as Map<String, dynamic>),
      appointmentDetails: AppointmentDetails.fromJson(
        json['appointmentDetails'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  List<Object?> get props => [home, appointmentDetails];
}
