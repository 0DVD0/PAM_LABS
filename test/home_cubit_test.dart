import 'package:flutter_test/flutter_test.dart';
import 'package:lab_3/cubits/home/home_cubit.dart';
import 'package:lab_3/cubits/home/home_state.dart';
import 'package:lab_3/data/data_sources/medical_local_data_source.dart';
import 'package:lab_3/data/repositories/medical_repository.dart';
import 'package:lab_3/models/app_data.dart';
import 'package:lab_3/models/appointment_details.dart';
import 'package:lab_3/models/appointment_slot.dart';
import 'package:lab_3/models/appointment_summary.dart';
import 'package:lab_3/models/doctor.dart';
import 'package:lab_3/models/health_service.dart';
import 'package:lab_3/models/home_data.dart';
import 'package:lab_3/models/user_profile.dart';

class _FakeRepository extends MedicalRepository {
  final AppData? data;
  final bool shouldThrow;

  _FakeRepository({this.data, this.shouldThrow = false})
    : super(MedicalLocalDataSource());

  @override
  Future<AppData> getMedicalData() async {
    if (shouldThrow) throw Exception('test error');
    return data!;
  }
}

const _doctors = [
  Doctor(
    id: '1',
    name: 'Dr. Alpha',
    specialty: 'General Practitioner',
    address: 'Alpha Street',
    distanceMeters: 500,
    consultationPrice: 90,
    listImageAsset: 'lib/img/near_doc_1.jpg',
    profileImageAsset: 'lib/img/near_doc_1.jpg',
    isFavorite: false,
  ),
  Doctor(
    id: '2',
    name: 'Dr. Beta',
    specialty: 'Dental Specialist',
    address: 'Beta Street',
    distanceMeters: 300,
    consultationPrice: 120,
    listImageAsset: 'lib/img/near_doc_2.jpg',
    profileImageAsset: 'lib/img/near_doc_2.jpg',
    isFavorite: false,
  ),
];

const _details = AppointmentDetails(
  title: 'Appointment',
  clinic: 'Clinic',
  payment: PaymentData(label: 'Payment', amount: 120, currency: 'USD'),
  detailsTitle: 'Details',
  description: 'Description',
  workingHoursTitle: 'Working Hours',
  workingHours: [AppointmentSlot(id: '10', label: '10:00', selected: true)],
  dateTitle: 'Date',
  dates: [AppointmentSlot(id: 'day', label: 'Sun 4', selected: true)],
  bookButtonLabel: 'Book',
);

const _appData = AppData(
  home: HomeData(
    user: UserProfile(
      name: 'User',
      greeting: 'Hi',
      subtitle: 'Welcome',
      imageAsset: 'lib/img/profile_pic.jpg',
    ),
    hasUnreadNotifications: false,
    searchHint: 'Search',
    appointment: AppointmentSummary(
      title: 'Appointment',
      date: 'Date',
      time: 'Time',
      doctor: AppointmentDoctor(
        id: '1',
        name: 'Dr. Alpha',
        specialty: 'General Practitioner',
        imageAsset: 'lib/img/near_doc_1.jpg',
      ),
    ),
    healthServices: [
      HealthService(
        id: 'tooth',
        name: 'Tooth',
        imageAsset: 'lib/img/tooth.png',
      ),
    ],
    nearbyDoctors: _doctors,
  ),
  appointmentDetails: _details,
);

void main() {
  test('emits Success after loading data', () async {
    final cubit = HomeCubit(_FakeRepository(data: _appData));

    await cubit.loadData();

    expect(cubit.state, isA<HomeSuccess>());
    final state = cubit.state as HomeSuccess;
    expect(state.visibleDoctors, hasLength(2));
    await cubit.close();
  });

  test('search can produce Empty and reset returns Success', () async {
    final cubit = HomeCubit(_FakeRepository(data: _appData));
    await cubit.loadData();

    cubit.searchDoctors('missing');
    expect(cubit.state, isA<HomeEmpty>());

    cubit.resetFilters();
    expect(cubit.state, isA<HomeSuccess>());
    await cubit.close();
  });

  test('favorite filter is controlled by Cubit', () async {
    final cubit = HomeCubit(_FakeRepository(data: _appData));
    await cubit.loadData();

    cubit.toggleFavorite('2');
    cubit.selectFilter(DoctorFilter.favorites);

    final state = cubit.state as HomeSuccess;
    expect(state.visibleDoctors.single.id, '2');
    expect(state.visibleDoctors.single.isFavorite, isTrue);
    await cubit.close();
  });

  test('emits Error when repository throws', () async {
    final cubit = HomeCubit(_FakeRepository(shouldThrow: true));

    await cubit.loadData();

    expect(cubit.state, isA<HomeError>());
    await cubit.close();
  });
}
