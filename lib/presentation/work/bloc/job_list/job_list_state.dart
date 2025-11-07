import 'package:equatable/equatable.dart'; 
import 'package:mini_project1/core/data/model/job_model.dart';

abstract class JobListState extends Equatable {
  const JobListState();
  
  @override
  List<Object> get props => [];
}

// State Awal: Saat BLoC baru dibuat
class JobListInitial extends JobListState {}

// State Loading: Saat BLoC sedang memanggil API
class JobListLoading extends JobListState {}

// State Loaded: Saat data berhasil didapat
class JobListLoaded extends JobListState {
  // Kita simpan hasil dari API di sini
  // Perhatikan, kita menyimpan 'JobModel' (kelas induk dari Quicktype)
  final JobModel jobModel;

  const JobListLoaded(this.jobModel);

  @override
  List<Object> get props => [jobModel];
}

// State Error: Jika terjadi kegagalan (API error / tidak ada internet)
class JobListError extends JobListState {
  final String message;

  const JobListError(this.message);

  @override
  List<Object> get props => [message];
}

class JobListServerError extends JobListState {
  final String message;
  const JobListServerError(this.message);

  @override
  List<Object> get props => [message];
}

// 2. Buat state BARU untuk error koneksi
class JobListConnectionError extends JobListState {
  final String message;
  const JobListConnectionError(this.message);

  @override
  List<Object> get props => [message];
}
