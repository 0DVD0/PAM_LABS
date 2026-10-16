import 'dart:convert';

import 'package:flutter/services.dart';

class MedicalLocalDataSource {
  final AssetBundle assetBundle;

  MedicalLocalDataSource({AssetBundle? assetBundle})
    : assetBundle = assetBundle ?? rootBundle;

  Future<Map<String, dynamic>> loadMedicalData() async {
    final jsonString = await assetBundle.loadString(
      'assets/data/medical_data.json',
    );
    final decoded = jsonDecode(jsonString);

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid root JSON structure');
    }

    return decoded;
  }
}
