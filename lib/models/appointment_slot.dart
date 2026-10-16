import 'package:equatable/equatable.dart';

class AppointmentSlot extends Equatable {
  final String id;
  final String label;
  final bool selected;

  const AppointmentSlot({
    required this.id,
    required this.label,
    required this.selected,
  });

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
    return AppointmentSlot(
      id: json['id'] as String,
      label: json['label'] as String,
      selected: json['selected'] as bool,
    );
  }

  @override
  List<Object?> get props => [id, label, selected];
}
