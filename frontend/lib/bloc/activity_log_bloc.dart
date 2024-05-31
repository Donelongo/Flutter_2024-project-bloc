import 'package:flutter_bloc/flutter_bloc.dart';
import 'activity_log_event.dart';
import 'activity_log_state.dart';

class ActivityLogBloc extends Bloc<ActivityLogEvent, ActivityLogState> {
  ActivityLogBloc() : super(ActivitiesLoading()) {
    on<LoadActivitiesEvent>(_onLoadActivities);
    on<AddActivityEvent>(_onAddActivity);
  }

  void _onLoadActivities(LoadActivitiesEvent event, Emitter<ActivityLogState> emit) async {
    try {
      // Simulate loading activities from a data source
      await Future.delayed(const Duration(seconds: 2));
      // Example activities (replace with your data fetching logic)
      final activities = [
        Activity(user: 'User1', activity: 'Running', dateTime: DateTime.now().subtract(const Duration(hours: 1))),
        Activity(user: 'User2', activity: 'Reading', dateTime: DateTime.now().subtract(const Duration(days: 1))),
      ];
      emit(ActivitiesLoaded(activities: activities));
    } catch (e) {
      emit(ActivitiesLoadFailed(error: e.toString()));
    }
  }

  void _onAddActivity(AddActivityEvent event, Emitter<ActivityLogState> emit) {
    if (state is ActivitiesLoaded) {
      final currentState = state as ActivitiesLoaded;
      final updatedActivities = List<Activity>.from(currentState.activities)
        ..add(Activity(user: event.user, activity: event.activity, dateTime: event.dateTime));
      emit(ActivitiesLoaded(activities: updatedActivities));
    }
  }
}
