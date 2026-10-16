import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_3/data/data_sources/medical_local_data_source.dart';
import 'package:lab_3/data/repositories/medical_repository.dart';
import 'package:lab_3/main.dart';

void main() {
  testWidgets('loads data, handles Empty, navigates and books', (tester) async {
    final repository = MedicalRepository(MedicalLocalDataSource());
    await tester.pumpWidget(MedicalApp(repository: repository));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('Hi, Jonathan'), findsOneWidget);
    expect(find.text('Nearby Doctors'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('doctor-search-field')),
      'unknown doctor',
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('No doctors found'), findsOneWidget);
    expect(find.text('Reset filters'), findsOneWidget);

    await tester.tap(find.text('Reset filters'));
    await tester.pump();

    await tester.tap(find.text('Appointment').first);
    await tester.pumpAndSettle();

    expect(find.text('Working Hours'), findsOneWidget);
    expect(find.text('Book an Appointment'), findsOneWidget);

    await tester.tap(find.byKey(const Key('book-appointment-button')));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.textContaining('Appointment booked'), findsOneWidget);
  });
}
