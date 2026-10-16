import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/appointment_details.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentDetails details;

  AppointmentCubit(this.details)
    : super(
        AppointmentState(
          selectedHourId: _initialHourId(details),
          selectedDateId: _initialDateId(details),
        ),
      );

  static String _initialHourId(AppointmentDetails details) {
    return details.workingHours
        .firstWhere(
          (slot) => slot.selected,
          orElse: () => details.workingHours.first,
        )
        .id;
  }

  static String _initialDateId(AppointmentDetails details) {
    return details.dates
        .firstWhere((slot) => slot.selected, orElse: () => details.dates.first)
        .id;
  }

  void selectHour(String id) {
    emit(state.copyWith(selectedHourId: id, clearMessage: true));
  }

  void selectDate(String id) {
    emit(state.copyWith(selectedDateId: id, clearMessage: true));
  }

  Future<void> bookAppointment() async {
    emit(state.copyWith(isBooking: true, clearMessage: true));
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final hour = details.workingHours
        .firstWhere((slot) => slot.id == state.selectedHourId)
        .label;
    final date = details.dates
        .firstWhere((slot) => slot.id == state.selectedDateId)
        .label;

    emit(
      state.copyWith(
        isBooking: false,
        confirmationMessage: 'Appointment booked for $date at $hour.',
      ),
    );
  }
}
