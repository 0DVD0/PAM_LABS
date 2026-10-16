import 'package:equatable/equatable.dart';

import 'appointment_slot.dart';

class PaymentData extends Equatable {
  final String label;
  final double amount;
  final String currency;

  const PaymentData({
    required this.label,
    required this.amount,
    required this.currency,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      label: json['label'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
    );
  }

  String get formatted => currency == 'USD'
      ? '\$${amount.toStringAsFixed(2)}'
      : '${amount.toStringAsFixed(2)} $currency';

  @override
  List<Object?> get props => [label, amount, currency];
}

class AppointmentDetails extends Equatable {
  final String title;
  final String clinic;
  final PaymentData payment;
  final String detailsTitle;
  final String description;
  final String workingHoursTitle;
  final List<AppointmentSlot> workingHours;
  final String dateTitle;
  final List<AppointmentSlot> dates;
  final String bookButtonLabel;

  const AppointmentDetails({
    required this.title,
    required this.clinic,
    required this.payment,
    required this.detailsTitle,
    required this.description,
    required this.workingHoursTitle,
    required this.workingHours,
    required this.dateTitle,
    required this.dates,
    required this.bookButtonLabel,
  });

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) {
    final details = json['details'] as Map<String, dynamic>;
    final workingHours = json['workingHours'] as Map<String, dynamic>;
    final date = json['date'] as Map<String, dynamic>;

    return AppointmentDetails(
      title: json['title'] as String,
      clinic: json['clinic'] as String,
      payment: PaymentData.fromJson(json['payment'] as Map<String, dynamic>),
      detailsTitle: details['title'] as String,
      description: details['description'] as String,
      workingHoursTitle: workingHours['title'] as String,
      workingHours: (workingHours['slots'] as List<dynamic>)
          .map((item) => AppointmentSlot.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      dateTitle: date['title'] as String,
      dates: (date['slots'] as List<dynamic>)
          .map((item) => AppointmentSlot.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      bookButtonLabel: json['bookButtonLabel'] as String,
    );
  }

  @override
  List<Object?> get props => [
    title,
    clinic,
    payment,
    detailsTitle,
    description,
    workingHoursTitle,
    workingHours,
    dateTitle,
    dates,
    bookButtonLabel,
  ];
}
