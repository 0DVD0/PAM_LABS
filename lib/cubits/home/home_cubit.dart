import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/medical_repository.dart';
import '../../models/appointment_details.dart';
import '../../models/doctor.dart';
import '../../models/home_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MedicalRepository repository;

  HomeData? _homeData;
  AppointmentDetails? _appointmentDetails;
  List<Doctor> _allDoctors = const [];
  String _searchQuery = '';
  DoctorFilter _filter = DoctorFilter.all;
  DoctorSort _sort = DoctorSort.nameAscending;

  HomeCubit(this.repository) : super(const HomeLoading());

  Future<void> loadData() async {
    emit(const HomeLoading());

    try {
      final data = await repository.getMedicalData();
      _homeData = data.home;
      _appointmentDetails = data.appointmentDetails;
      _allDoctors = List<Doctor>.of(data.home.nearbyDoctors);
      _searchQuery = '';
      _filter = DoctorFilter.all;
      _sort = DoctorSort.nameAscending;
      _applyFilters();
    } on FormatException catch (error) {
      emit(HomeError('Invalid JSON data: ${error.message}'));
    } catch (_) {
      emit(const HomeError('Medical data could not be loaded.'));
    }
  }

  void searchDoctors(String query) {
    _searchQuery = query.trim().toLowerCase();
    _applyFilters();
  }

  void selectFilter(DoctorFilter filter) {
    _filter = filter;
    _applyFilters();
  }

  void selectSort(DoctorSort sort) {
    _sort = sort;
    _applyFilters();
  }

  void toggleFavorite(String doctorId) {
    _allDoctors = _allDoctors
        .map((doctor) {
          if (doctor.id != doctorId) return doctor;
          return doctor.copyWith(isFavorite: !doctor.isFavorite);
        })
        .toList(growable: false);
    _applyFilters();
  }

  void resetFilters() {
    _searchQuery = '';
    _filter = DoctorFilter.all;
    _sort = DoctorSort.nameAscending;
    _applyFilters();
  }

  void _applyFilters() {
    final homeData = _homeData;
    final details = _appointmentDetails;

    if (homeData == null || details == null) {
      emit(const HomeError('Application data is not available.'));
      return;
    }

    var doctors = _allDoctors
        .where(_matchesSearch)
        .where(_matchesFilter)
        .toList();
    doctors.sort(_compareDoctors);

    if (doctors.isEmpty) {
      final message = _searchQuery.isNotEmpty
          ? 'No doctors found for “$_searchQuery”.'
          : 'No doctors match the selected filter.';
      emit(HomeEmpty(message));
      return;
    }

    emit(
      HomeSuccess(
        homeData: homeData,
        appointmentDetails: details,
        visibleDoctors: doctors,
        searchQuery: _searchQuery,
        filter: _filter,
        sort: _sort,
      ),
    );
  }

  bool _matchesSearch(Doctor doctor) {
    if (_searchQuery.isEmpty) return true;
    return doctor.name.toLowerCase().contains(_searchQuery) ||
        doctor.specialty.toLowerCase().contains(_searchQuery);
  }

  bool _matchesFilter(Doctor doctor) {
    return switch (_filter) {
      DoctorFilter.all => true,
      DoctorFilter.general => doctor.specialty == 'General Practitioner',
      DoctorFilter.dental => doctor.specialty == 'Dental Specialist',
      DoctorFilter.child => doctor.specialty == 'Child Specialist',
      DoctorFilter.favorites => doctor.isFavorite,
    };
  }

  int _compareDoctors(Doctor first, Doctor second) {
    return switch (_sort) {
      DoctorSort.nameAscending => first.name.compareTo(second.name),
      DoctorSort.nameDescending => second.name.compareTo(first.name),
      DoctorSort.distanceAscending => first.distanceMeters.compareTo(
        second.distanceMeters,
      ),
    };
  }
}
