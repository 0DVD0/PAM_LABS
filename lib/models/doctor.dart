class Doctor {
  final String name;
  final String speciality;
  final String address;
  final double distanceInMeters;
  final double consultationPrice;
  final String listImageAsset;
  final String profileImageAsset;

  const Doctor({
    required this.name,
    required this.speciality,
    required this.address,
    required this.distanceInMeters,
    required this.consultationPrice,
    required this.listImageAsset,
    required this.profileImageAsset,
  });
}
