import 'package:equatable/equatable.dart';

abstract class JobListEvent extends Equatable {
  const JobListEvent();

  @override
  List<Object> get props => [];
}

class FetchJobList extends JobListEvent {}