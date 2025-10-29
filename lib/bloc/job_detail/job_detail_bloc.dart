import 'package:flutter_bloc/flutter_bloc.dart';
import 'job_detail_event.dart';
import 'job_detail_state.dart';
import '../../data/models/job_detail_model.dart'; // Import model detail

// --- TAMBAHKAN IMPORT INI ---
import 'package:http/http.dart' as http;

// -----------------------------

// HAPUS 'ApiService' DARI SINI
// class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
//   final ApiService apiService;
//   JobDetailBloc(this.apiService) : super(JobDetailInitial()) {
// ...

// GANTI DENGAN INI (BLoC TANPA ApiService)
class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  // --- SALIN TOKEN VALID ANDA KE SINI ---
  final String _token = 
  "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wva2tsb2tlci5wYXJ0bmVyY29kaW5nLmNvbVwvYXBpXC9qb2JzZWVrZXJcL3Bla2VyamFhblwvZ2V0QWN0aXZlUGVrZWphYW4iLCJpYXQiOjE3NjE1MzQ4MTMsImV4cCI6MTc2MTgwNDYyNSwibmJmIjoxNzYxNzE4MjI1LCJqdGkiOiJQZm1zZnBadE4zRmhvcFNSIiwic3ViIjoyLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.dhorE-40X5W7laR4dDg5G7v-UJFd144NRD9IwTMWzWM";
  
  JobDetailBloc() : super(JobDetailInitial()) {
    on<FetchJobDetail>((event, emit) async {
      emit(JobDetailLoading());

      // Ambil ID dari event
      final String jobId = event.jobId;

      // --- KITA PINDAHKAN LOGIKA API KE SINI ---
      final url = Uri.parse(
          'https://kkloker.partnercoding.com/api/jobseeker/pekerjaan/getActivePekejaan/$jobId');

      try {
        print("--- DETAIL BLOC: Mencoba memanggil API untuk ID: $jobId ---");

        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
          },
        ).timeout(const Duration(seconds: 15));

        print(
            "--- DETAIL BLOC BERHASIL: Status Code ${response.statusCode} ---");

        if (response.statusCode == 200) {
          // Jika sukses, kita parsing di sini
          final JobDetailModel jobDetail =
              JobDetailModel.fromRawJson(response.body);
          emit(JobDetailLoaded(jobDetail));
        } else {
          // Jika status code bukan 200
          throw Exception('Gagal memuat (Status: ${response.statusCode})');
        }
      } catch (e) {
        // Jika parsing atau http gagal
        print("!!! KESALAHAN DETAIL BLOC: $e");
        emit(JobDetailError(e.toString()));
      }
      // -------------------------------------------
    });
  }
}