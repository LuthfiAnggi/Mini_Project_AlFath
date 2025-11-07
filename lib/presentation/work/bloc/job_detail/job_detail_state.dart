import 'package:equatable/equatable.dart';
import 'package:mini_project1/core/data/model/job_detail_model.dart';

abstract class JobDetailState extends Equatable {
  const JobDetailState();
  @override
  List<Object> get props => [];
}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState {}

class JobDetailLoaded extends JobDetailState {
  final JobDetailModel jobDetail; // Kirim data detail ke UI
  const JobDetailLoaded(this.jobDetail);
  @override
  List<Object> get props => [jobDetail];
}

class JobDetailError extends JobDetailState {
  final String message;
  const JobDetailError(this.message);
  @override
  List<Object> get props => [message];
}