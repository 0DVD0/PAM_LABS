import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_colors.dart';
import '../cubits/appointment/appointment_cubit.dart';
import '../cubits/appointment/appointment_state.dart';
import '../models/appointment_details.dart';
import '../models/appointment_slot.dart';
import '../models/doctor.dart';
import '../widgets/doctor_profile_card.dart';
import '../widgets/section_header.dart';
import '../widgets/selectable_option.dart';

class AppointmentScreen extends StatelessWidget {
  final Doctor doctor;
  final AppointmentDetails details;

  const AppointmentScreen({
    super.key,
    required this.doctor,
    required this.details,
  });

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listenWhen: (previous, current) =>
          previous.confirmationMessage != current.confirmationMessage &&
          current.confirmationMessage != null,
      listener: (context, state) {
        _showMessage(context, state.confirmationMessage!);
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DoctorProfileCard(
                          doctor: doctor,
                          details: details,
                          onContactPressed: (action) {
                            _showMessage(context, '$action ${doctor.name}');
                          },
                        ),
                        const SizedBox(height: 34),
                        Text(
                          details.detailsTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          details.description,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 32),
                        SectionHeader(
                          title: details.workingHoursTitle,
                          onSeeAll: () =>
                              _showMessage(context, 'All working hours'),
                        ),
                        const SizedBox(height: 12),
                        _buildOptions(
                          context: context,
                          values: details.workingHours,
                          selectedId: state.selectedHourId,
                          onSelected: context
                              .read<AppointmentCubit>()
                              .selectHour,
                        ),
                        const SizedBox(height: 28),
                        SectionHeader(
                          title: details.dateTitle,
                          onSeeAll: () =>
                              _showMessage(context, 'Calendar opened'),
                        ),
                        const SizedBox(height: 12),
                        _buildOptions(
                          context: context,
                          values: details.dates,
                          selectedId: state.selectedDateId,
                          onSelected: context
                              .read<AppointmentCubit>()
                              .selectDate,
                        ),
                      ],
                    ),
                  ),
                ),
                _buildBookButton(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 24, 6),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          Expanded(
            child: Text(
              details.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildOptions({
    required BuildContext context,
    required List<AppointmentSlot> values,
    required String selectedId,
    required ValueChanged<String> onSelected,
  }) {
    return Row(
      children: List.generate(values.length, (index) {
        final value = values[index];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < values.length - 1 ? 10 : 0),
            child: SelectableOption(
              text: value.label,
              selected: selectedId == value.id,
              onTap: () => onSelected(value.id),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBookButton(BuildContext context, AppointmentState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          key: const Key('book-appointment-button'),
          onPressed: state.isBooking
              ? null
              : context.read<AppointmentCubit>().bookAppointment,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: state.isBooking
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  details.bookButtonLabel,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
