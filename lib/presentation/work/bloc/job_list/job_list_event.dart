import 'package:equatable/equatable.dart';

abstract class JobListEvent extends Equatable {
  const JobListEvent();
  @override
  List<Object?> get props => []; // Ubah jadi List<Object?>
}

class FetchJobList extends JobListEvent {
  // Tambahkan field filters
  final Map<String, String>? filters;

  // Buat opsional di constructor
  const FetchJobList({this.filters});

  @override
  List<Object?> get props => [filters];
}

class SearchQueryChanged extends JobListEvent {
  final String query;
  
  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}