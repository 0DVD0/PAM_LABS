import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';
import '../widgets/appointment_card.dart';
import '../widgets/doctor_tile.dart';
import '../widgets/section_header.dart';
import '../widgets/service_item.dart';
import 'appointment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Doctor _appointmentDoctor = Doctor(
    name: 'Dr. Richard Kandowen',
    speciality: 'Child Specialist',
    address: 'Medical Center',
    distanceInMeters: 500,
    consultationPrice: 120,
    listImageAsset: 'lib/img/home_appoint_doc.jpg',
    profileImageAsset: 'lib/img/appoint_page_doc.jpg',
  );

  static const Appointment _appointment = Appointment(
    doctor: _appointmentDoctor,
    date: '22 October, 2026',
    time: '08:00 AM - 10:30 AM',
  );

  static const List<Doctor> _nearbyDoctors = [
    Doctor(
      name: 'Dr. Emmly Lestiryno',
      speciality: 'General Practitioner',
      address: '3167 Durgan Shores',
      distanceInMeters: 500,
      consultationPrice: 90,
      listImageAsset: 'lib/img/near_doc_1.jpg',
      profileImageAsset: 'lib/img/near_doc_1.jpg',
    ),
    Doctor(
      name: 'Dr. Sonja Littel',
      speciality: 'Dental Specialist',
      address: '950 Sigrid Port',
      distanceInMeters: 753,
      consultationPrice: 120,
      listImageAsset: 'lib/img/near_doc_2.jpg',
      profileImageAsset: 'lib/img/near_doc_2.jpg',
    ),
  ];

  void _openAppointment(BuildContext context, Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AppointmentScreen(doctor: doctor)),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 28),
              _buildSearchField(context),
              const SizedBox(height: 28),
              AppointmentCard(
                appointment: _appointment,
                onTap: () => _openAppointment(context, _appointmentDoctor),
                onMessageTap: () =>
                    _showMessage(context, 'Write a message to the doctor'),
              ),
              const SizedBox(height: 26),
              SectionHeader(
                title: 'Health Services',
                onSeeAll: () => _showMessage(context, 'All health services'),
              ),
              const SizedBox(height: 12),
              _buildHealthServices(context),
              const SizedBox(height: 26),
              SectionHeader(
                title: 'Nearby Doctors',
                onSeeAll: () => _showMessage(context, 'All nearby doctors'),
              ),
              ..._nearbyDoctors.map(
                (doctor) => DoctorTile(
                  doctor: doctor,
                  onTap: () => _openAppointment(context, doctor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.lightBlue,
          backgroundImage: AssetImage('lib/img/profile_pic.jpg'),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Jonathan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'May you always be healthy',
                style: TextStyle(fontSize: 13, color: AppColors.grey),
              ),
            ],
          ),
        ),
        Badge(
          child: IconButton(
            onPressed: () => _showMessage(context, 'No new notifications'),
            icon: const Icon(Icons.notifications_none, size: 30),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          _showMessage(context, 'Searching for: ${value.trim()}');
        }
      },
      decoration: InputDecoration(
        hintText: 'Search something',
        hintStyle: const TextStyle(color: AppColors.grey),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: () => _showMessage(context, 'Filters opened'),
          icon: const Icon(Icons.tune),
        ),
        filled: true,
        fillColor: AppColors.lightGrey,
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildHealthServices(BuildContext context) {
    const services = [
      (imageAsset: 'lib/img/tooth.png', label: 'Tooth'),
      (imageAsset: 'lib/img/eye.png', label: 'Eye'),
      (imageAsset: 'lib/img/lung.png', label: 'Lungs'),
      (imageAsset: 'lib/img/ear.png', label: 'Ear'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: services
          .map(
            (service) => ServiceItem(
              imageAsset: service.imageAsset,
              label: service.label,
              onTap: () => _showMessage(context, '${service.label} selected'),
            ),
          )
          .toList(),
    );
  }
}
