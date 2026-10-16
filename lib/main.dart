import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/app_colors.dart';
import 'cubits/home/home_cubit.dart';
import 'data/data_sources/medical_local_data_source.dart';
import 'data/repositories/medical_repository.dart';
import 'screens/home_screen.dart';

void main() {
  final dataSource = MedicalLocalDataSource();
  final repository = MedicalRepository(dataSource);
  runApp(MedicalApp(repository: repository));
}

class MedicalApp extends StatelessWidget {
  final MedicalRepository repository;

  const MedicalApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: BlocProvider(
        create: (_) => HomeCubit(repository)..loadData(),
        child: const HomeScreen(),
      ),
    );
  }
}
