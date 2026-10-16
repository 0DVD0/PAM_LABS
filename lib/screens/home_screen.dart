import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_colors.dart';
import '../cubits/appointment/appointment_cubit.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';
import '../models/doctor.dart';
import '../widgets/appointment_card.dart';
import '../widgets/doctor_controls.dart';
import '../widgets/doctor_tile.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/section_header.dart';
import '../widgets/service_item.dart';
import 'appointment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return switch (state) {
              HomeLoading() => const LoadingView(),
              HomeError() => ErrorView(
                message: state.message,
                onRetry: context.read<HomeCubit>().loadData,
              ),
              HomeEmpty() => EmptyView(
                message: state.message,
                onReset: context.read<HomeCubit>().resetFilters,
              ),
              HomeSuccess() => _HomeContent(state: state),
            };
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final HomeSuccess state;

  const _HomeContent({required this.state});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _openAppointment(BuildContext context, Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AppointmentCubit(state.appointmentDetails),
          child: AppointmentScreen(
            doctor: doctor,
            details: state.appointmentDetails,
          ),
        ),
      ),
    );
  }

  Doctor get _appointmentDoctor {
    final id = state.homeData.appointment.doctor.id;
    return state.homeData.nearbyDoctors.firstWhere(
      (doctor) => doctor.id == id,
      orElse: () => state.homeData.nearbyDoctors.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = state.homeData;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 28),
          _buildSearchField(context),
          const SizedBox(height: 28),
          AppointmentCard(
            appointment: home.appointment,
            onTap: () => _openAppointment(context, _appointmentDoctor),
            onMessageTap: () => _showMessage(
              context,
              'Write a message to ${home.appointment.doctor.name}',
            ),
          ),
          const SizedBox(height: 26),
          SectionHeader(
            title: 'Health Services',
            onSeeAll: () => _showMessage(context, 'All health services'),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: home.healthServices
                .map(
                  (service) => ServiceItem(
                    service: service,
                    onTap: () =>
                        _showMessage(context, '${service.name} selected'),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 26),
          const SectionHeader(title: 'Nearby Doctors'),
          DoctorControls(
            selectedFilter: state.filter,
            selectedSort: state.sort,
            onFilterSelected: context.read<HomeCubit>().selectFilter,
            onSortSelected: context.read<HomeCubit>().selectSort,
          ),
          ...state.visibleDoctors.map(
            (doctor) => DoctorTile(
              doctor: doctor,
              onTap: () => _openAppointment(context, doctor),
              onFavoritePressed: () {
                context.read<HomeCubit>().toggleFavorite(doctor.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final user = state.homeData.user;

    return Row(
      children: [
        CircleAvatar(radius: 28, backgroundImage: AssetImage(user.imageAsset)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.greeting,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.subtitle,
                style: const TextStyle(fontSize: 13, color: AppColors.grey),
              ),
            ],
          ),
        ),
        Badge(
          isLabelVisible: state.homeData.hasUnreadNotifications,
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
      key: const Key('doctor-search-field'),
      onChanged: context.read<HomeCubit>().searchDoctors,
      decoration: InputDecoration(
        hintText: state.homeData.searchHint,
        hintStyle: const TextStyle(color: AppColors.grey),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.tune),
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
}
