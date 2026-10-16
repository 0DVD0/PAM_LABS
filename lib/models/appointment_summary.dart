import 'package:equatable/equatable.dart';

class AppointmentDoctor extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String imageAsset;

  const AppointmentDoctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageAsset,
  });

  factory AppointmentDoctor.fromJson(Map<String, dynamic> json) {
    return AppointmentDoctor(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      imageAsset: json['imageAsset'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, specialty, imageAsset];
}

class AppointmentSummary extends Equatable {
  final String title;
  final String date;
  final String time;
  final AppointmentDoctor doctor;

  const AppointmentSummary({
    required this.title,
    required this.date,
    required this.time,
    required this.doctor,
  });

  factory AppointmentSummary.fromJson(Map<String, dynamic> json) {
    return AppointmentSummary(
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      doctor: AppointmentDoctor.fromJson(
        json['doctor'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  List<Object?> get props => [title, date, time, doctor];
}
