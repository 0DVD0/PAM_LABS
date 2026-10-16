import 'package:equatable/equatable.dart';

import '../../models/appointment_details.dart';
import '../../models/doctor.dart';
import '../../models/home_data.dart';

enum DoctorFilter { all, general, dental, child, favorites }

enum DoctorSort { nameAscending, nameDescending, distanceAscending }

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  final HomeData homeData;
  final AppointmentDetails appointmentDetails;
  final List<Doctor> visibleDoctors;
  final String searchQuery;
  final DoctorFilter filter;
  final DoctorSort sort;

  const HomeSuccess({
    required this.homeData,
    required this.appointmentDetails,
    required this.visibleDoctors,
    required this.searchQuery,
    required this.filter,
    required this.sort,
  });

  @override
  List<Object?> get props => [
    homeData,
    appointmentDetails,
    visibleDoctors,
    searchQuery,
    filter,
    sort,
  ];
}

class HomeEmpty extends HomeState {
  final String message;

  const HomeEmpty(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
