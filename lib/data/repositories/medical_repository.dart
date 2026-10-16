import '../../models/app_data.dart';
import '../data_sources/medical_local_data_source.dart';

class MedicalRepository {
  final MedicalLocalDataSource localDataSource;

  const MedicalRepository(this.localDataSource);

  Future<AppData> getMedicalData() async {
    final json = await localDataSource.loadMedicalData();
    return AppData.fromJson(json);
  }
}
