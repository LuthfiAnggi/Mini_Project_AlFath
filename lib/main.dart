import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/config/theme_config.dart';
import 'package:mini_project1/core/data/datasource/auth_remote_datasource.dart';
import 'package:mini_project1/presentation/auth/bloc/auth_bloc.dart';
import 'package:mini_project1/presentation/auth/page/auth_options_page.dart';
import 'package:mini_project1/presentation/onboarding/page/onboarding1_page.dart';
import 'core/data/datasource/job_remote_datasource.dart';
// import 'package:mini_project1/data/services/api_service.dart';
import 'presentation/work/bloc/job_list/job_list_bloc.dart';
import 'presentation/work/bloc/job_detail/job_detail_bloc.dart';
import 'presentation/work/page/work_page.dart';// Ganti nama proyek Anda

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Kita daftarkan semua Repository/Service di sini
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiService()),
       
        RepositoryProvider(
          create: (context) => Connectivity(),
        ),

        RepositoryProvider(
          create: (context) => AuthRemoteDatasource(), // <-- TAMBAHKAN INI
        ),
      ],
      

      // 2. Kita daftarkan semua BLoC di sini
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => JobListBloc(
              // Ambil ApiService yang sudah disediakan di atas
              context.read<ApiService>(),
              context.read<Connectivity>(),
            ),
          ),

          BlocProvider(
            create: (context) => JobDetailBloc(
              // context.read<Connectivity>(),
            ), // Panggil constructor kosong
          ),

          BlocProvider(
            create: (context) => AuthBloc(
              // 3. "AMBIL" DATASOURCE DARI ATAS DAN BERIKAN KE BLOC
              context.read<AuthRemoteDatasource>(), 
            ),
          ),
        ],

        // 3. Baru kita panggil MaterialApp
        child: MaterialApp(
          title: 'Job App',
          theme: ThemeConfig.lightMode,
          debugShowCheckedModeBanner: false,
          // home: JobListPage(),
          home: AuthOptionsPage(), // <-- Halaman utama Anda
        ),
      ),
    );
  }
}
