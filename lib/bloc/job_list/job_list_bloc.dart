import 'package:bloc/bloc.dart';

import 'package:mini_project1/data/models/job_model.dart';
import 'package:mini_project1/data/services/api_service.dart';

import 'job_list_event.dart';
import 'job_list_state.dart';

class JobListBloc extends Bloc<JobListEvent, JobListState> {
  final ApiService apiService;

  JobListBloc(this.apiService) : super(JobListInitial()) {
    on<FetchJobList>((event, emit) async {
      emit(JobListLoading());

      try {
        final JobModel jobModel = await apiService.getJobs();

        emit(JobListLoaded(jobModel));
      } catch (e) {
        print("!!! KESALAHAN BLOC: $e");
        emit(JobListError(e.toString()));
      }
    });
  }
}
