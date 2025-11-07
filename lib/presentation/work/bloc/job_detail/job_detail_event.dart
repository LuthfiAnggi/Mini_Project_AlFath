import 'package:equatable/equatable.dart';


abstract class JobDetailEvent extends Equatable {
  const JobDetailEvent();
  @override
  List<Object> get props => [];
}
// Event ini akan membawa ID lowongan dari UI ke BLoC
class FetchJobDetail extends JobDetailEvent {
  final String jobId;
  const FetchJobDetail(this.jobId);
  @override
  List<Object> get props => [jobId];
}