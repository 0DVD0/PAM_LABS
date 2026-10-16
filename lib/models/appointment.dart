import 'doctor.dart';

class Appointment {
  final Doctor doctor;
  final String date;
  final String time;

  const Appointment({
    required this.doctor,
    required this.date,
    required this.time,
  });
}
