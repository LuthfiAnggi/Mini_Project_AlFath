// lib/bloc/job_list/job_list_bloc.dart

import 'dart:async';
import 'dart:io'; // Diperlukan untuk SocketException (meskipun kita cek string)

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http; // Diperlukan untuk ClientException
import 'job_list_event.dart';
import 'job_list_state.dart';
import '../../data/models/job_model.dart';
import '../../data/services/api_service.dart';

class _ConnectivityChanged extends JobListEvent {
  final ConnectivityResult status;
  const _ConnectivityChanged(this.status);
}

class JobListBloc extends Bloc<JobListEvent, JobListState> {
  final ApiService apiService;
  final Connectivity connectivity;
  StreamSubscription? _connectivitySubscription;

  JobListBloc(this.apiService, this.connectivity) : super(JobListInitial()) {
    on<FetchJobList>(_onFetchJobList);
    on<_ConnectivityChanged>(_onConnectivityChanged);

    _connectivitySubscription = connectivity.onConnectivityChanged.listen((result) {
      add(_ConnectivityChanged(result.first));
    });
  }

  // LOGIKA RELOAD OTOMATIS (Ini sudah benar)
  Future<void> _onConnectivityChanged(
    _ConnectivityChanged event,
    Emitter<JobListState> emit,
  ) async {
    if (event.status != ConnectivityResult.none) {
      // Jika kita kembali online DAN sebelumnya kita error karena koneksi
      if (state is JobListError &&
          (state as JobListError).message.contains("Tidak ada koneksi")) {
        add(FetchJobList()); // Otomatis panggil API lagi
      }
    }
  }

  // --- LOGIKA FETCH UTAMA (INI YANG DIPERBAIKI) ---
  Future<void> _onFetchJobList(
    FetchJobList event,
    Emitter<JobListState> emit, // Pastikan ini JobListState
  ) async {
    // 1. Tampilkan loading, HANYA jika kita belum punya data
    if (state is! JobListLoaded) {
      emit(JobListLoading());
    }
    // Jika kita SUDAH punya data (state is JobListLoaded), kita tidak
    // emit Loading, sehingga UI tetap menampilkan data lama

    try {
      // 2. LANGSUNG panggil API
      final JobModel jobModel = await apiService.getJobs();
      emit(JobListLoaded(jobModel)); // Jika sukses, tampilkan data

    } catch (e) {
      print("!!! KESALAHAN JOB LIST BLOC: $e");

      // Cek apakah kita sudah punya data
      if (state is JobListLoaded) {
        // Jika sudah punya data, jangan tampilkan error apa pun.
        // Biarkan data lama tetap tampil.
        return;
      }

      // --- INI BAGIAN YANG DIPERBAIKI ---
      // Ubah pengecekan 'tipe' menjadi pengecekan 'string'
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('socketexception') ||
          errorMessage.contains('clientexception') ||
          errorMessage.contains('failed host lookup') ||
          errorMessage.contains('network is unreachable')) {
        
        emit(JobListError("Tidak ada koneksi internet"));
      } else {
        // Error lain (401, 500, parsing JSON, dll)
        emit(JobListError(e.toString()));
      }
      // --- AKHIR PERBAIKAN ---
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}