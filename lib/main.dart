import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/services/api_service.dart';
// import 'package:mini_project1/data/services/api_service.dart';
import 'bloc/job_list/job_list_bloc.dart';
import 'bloc/job_detail/job_detail_bloc.dart';
import 'presentation/pages/job_list_page.dart';

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
        // (Nanti bisa ditambah repository lain di sini)
      ],

      // 2. Kita daftarkan semua BLoC di sini
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => JobListBloc(
              // Ambil ApiService yang sudah disediakan di atas
              context.read<ApiService>(),
            ),
          ),

          // KODE BARU
          BlocProvider(
            create: (context) => JobDetailBloc(), // Panggil constructor kosong
          ),
        ],

        // 3. Baru kita panggil MaterialApp
        child: MaterialApp(
          title: 'Job App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: JobListPage(), // <-- Halaman utama Anda
        ),
      ),
    );
  }
}
