import 'package:digital_notebook/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'activity_log_event.dart';
import 'activity_log_state.dart';
import 'package:intl/intl.dart';

class ActivityLogBloc extends Bloc<ActivityLogEvent, ActivityLogState> {
  ActivityLogBloc() : super(ActivitiesLogInitial()) {
    on<LoadActivitiesEvent>(_onLoadActivities);
    on<AddActivityEvent>(_onAddActivity);
    on<DeleteActivityEvent>(_deleteActivity);
    on<UpdateActivityEvent>(_updateActivity);
  }

  void _onLoadActivities(
      LoadActivitiesEvent event, Emitter<ActivityLogState> emit) async {
    emit(ActivitiesLoading());
    try {
      // Simulate loading activities from a data source
      // await Future.delayed(const Duration(seconds: 2));
      // Example activities (replace with your data fetching logic)
      final date1 = DateTime.now().subtract(const Duration(hours: 2));
      final date2 = DateTime.now().subtract(const Duration(hours: 1));

      final formatter = DateFormat('yyyy-MM-dd');
      final timeFormatter = DateFormat.Hms();

      final firstDate = formatter.format(date1);
      final secondDate = formatter.format(date2);

      final firstTime = timeFormatter.format(date1);
      final secondTime = timeFormatter.format(date2);

      final activities = [
  Activity(
      user: 'User1',
      name: 'Running',
      date: firstDate,
      logs: ["There are some logs"],
      time: firstTime,
      id: '1'),
  Activity(
      user: 'User2',
      name: 'Reading',
      date: secondDate,
      logs: ["There are some logs"],
      time: secondTime,
      id: '2'), 
];
      emit(ActivitiesLoaded(activities: activities));
    } catch (e) {
      emit(ActivitiesLoadFailed(error: e.toString()));
    }
  }

  void _onAddActivity(AddActivityEvent event, Emitter<ActivityLogState> emit) {
    if (state is ActivitiesLoaded) {
      final currentState = state as ActivitiesLoaded;
      final updatedActivities = List<Activity>.of(currentState.activities);
      final formatter = DateFormat('yyyy-MM-dd');
      final timeFormatter = DateFormat.Hms();

      final date = formatter.format(event.dateTime);
      final time = timeFormatter.format(event.dateTime);
      updatedActivities.add(Activity(
          user: event.user, name: event.activity, date: date, time: time, id: '3', logs: []));
      emit(ActivitiesLoaded(activities: updatedActivities));
    }
  }

  void _deleteActivity(
      DeleteActivityEvent event, Emitter<ActivityLogState> emit) {
    if (state is ActivitiesLoaded) {
      final currentState = state as ActivitiesLoaded;
      final updatedActivities = List<Activity>.of(currentState.activities);
      updatedActivities
          .removeAt(event.activityId);
      emit(ActivitiesLoaded(activities: updatedActivities));
    }
  }

  void _updateActivity(UpdateActivityEvent event, Emitter<ActivityLogState> emit) {
    if (state is ActivitiesLoaded) {
      final currentState = state as ActivitiesLoaded;
      final updatedActivities = List<Activity>.of(currentState.activities);
      final formatter = DateFormat('yyyy-MM-dd');
      final timeFormatter = DateFormat.Hms();

      final date = formatter.format(event.dateTime);
      final time = timeFormatter.format(event.dateTime);
      
      debugPrint("Activities are $updatedActivities");
      updatedActivities[event.activityId] = Activity(
          user: event.user, name: event.activity, date: date, time: time, id: '4', logs: []);
      emit(ActivitiesLoaded(activities: updatedActivities));
    }
  }
}
