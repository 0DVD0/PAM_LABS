import 'package:flutter_test/flutter_test.dart';
import 'package:lab_2_doc/main.dart';

void main() {
  testWidgets('opens appointment screen from the appointment card', (
    tester,
  ) async {
    await tester.pumpWidget(const MedicalApp());

    expect(find.text('Hi, Jonathan'), findsOneWidget);
    expect(find.text('Health Services'), findsOneWidget);

    await tester.tap(find.text('Appointment'));
    await tester.pumpAndSettle();

    expect(find.text('Book an Appointment'), findsOneWidget);
    expect(find.text('Working Hours'), findsOneWidget);
  });
}
