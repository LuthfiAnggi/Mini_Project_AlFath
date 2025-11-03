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
  "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wva2tsb2tlci5wYXJ0bmVyY29kaW5nLmNvbVwvYXBpXC9sb2dpbiIsImlhdCI6MTc2MjE0MjAyMCwiZXhwIjoxNzYyMjI4NDIwLCJuYmYiOjE3NjIxNDIwMjAsImp0aSI6InpMMGJZRjFxYWx6OHdvTmEiLCJzdWIiOjIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ttCb8UHDonBAlR3LuTiSon3Xy2lSc1d05KyaPivuhco";
  
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