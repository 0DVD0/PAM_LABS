import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/doctor.dart';
import '../widgets/doctor_profile_card.dart';
import '../widgets/section_header.dart';
import '../widgets/selectable_option.dart';

class AppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  const AppointmentScreen({super.key, required this.doctor});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  static const List<String> _hours = ['10:00 AM', '11:00 AM', '12:00 PM'];
  static const List<String> _dates = ['Sun 4', 'Mon 5', 'Tue 6'];

  int _selectedHour = 1;
  int _selectedDate = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorProfileCard(
                      doctor: widget.doctor,
                      onContactPressed: (action) {
                        _showMessage('$action ${widget.doctor.name}');
                      },
                    ),
                    const SizedBox(height: 34),
                    _buildDetails(),
                    const SizedBox(height: 32),
                    SectionHeader(
                      title: 'Working Hours',
                      onSeeAll: () => _showMessage('All working hours'),
                    ),
                    const SizedBox(height: 12),
                    _buildOptions(
                      values: _hours,
                      selectedIndex: _selectedHour,
                      onSelected: (index) {
                        setState(() => _selectedHour = index);
                      },
                    ),
                    const SizedBox(height: 28),
                    SectionHeader(
                      title: 'Date',
                      onSeeAll: () => _showMessage('Calendar opened'),
                    ),
                    const SizedBox(height: 12),
                    _buildOptions(
                      values: _dates,
                      selectedIndex: _selectedDate,
                      onSelected: (index) {
                        setState(() => _selectedDate = index);
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 24, 6),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          const Expanded(
            child: Text(
              'Appointment',
              textAlign: TextAlign.center,
              style: TextStyle(
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

  Widget _buildDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 14),
        Text(
          'Choose a convenient day and hour for your consultation. '
          'The doctor will review your request and the appointment will '
          'appear in your schedule after confirmation.',
          style: TextStyle(color: AppColors.grey, fontSize: 16, height: 1.45),
        ),
      ],
    );
  }

  Widget _buildOptions({
    required List<String> values,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
  }) {
    return Row(
      children: List.generate(values.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < values.length - 1 ? 10 : 0),
            child: SelectableOption(
              text: values[index],
              selected: selectedIndex == index,
              onTap: () => onSelected(index),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBookButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          onPressed: () {
            _showMessage(
              'Appointment booked for ${_dates[_selectedDate]} at ${_hours[_selectedHour]}',
            );
          },
          child: const Text(
            'Book an Appointment',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
