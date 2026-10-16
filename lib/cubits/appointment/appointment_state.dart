import 'package:equatable/equatable.dart';

class AppointmentState extends Equatable {
  final String selectedHourId;
  final String selectedDateId;
  final bool isBooking;
  final String? confirmationMessage;

  const AppointmentState({
    required this.selectedHourId,
    required this.selectedDateId,
    this.isBooking = false,
    this.confirmationMessage,
  });

  AppointmentState copyWith({
    String? selectedHourId,
    String? selectedDateId,
    bool? isBooking,
    String? confirmationMessage,
    bool clearMessage = false,
  }) {
    return AppointmentState(
      selectedHourId: selectedHourId ?? this.selectedHourId,
      selectedDateId: selectedDateId ?? this.selectedDateId,
      isBooking: isBooking ?? this.isBooking,
      confirmationMessage: clearMessage
          ? null
          : confirmationMessage ?? this.confirmationMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedHourId,
    selectedDateId,
    isBooking,
    confirmationMessage,
  ];
}
