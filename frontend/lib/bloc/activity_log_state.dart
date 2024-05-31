import 'package:equatable/equatable.dart';

class ActivityLogState extends Equatable {
  const ActivityLogState();

  @override
  List<Object> get props => [];
}

class ActivitiesLoading extends ActivityLogState {}

class ActivitiesLoaded extends ActivityLogState {
  final List<Activity> activities;

  const ActivitiesLoaded({required this.activities});

  @override
  List<Object> get props => [activities];
}

class ActivitiesLoadFailed extends ActivityLogState {
  final String error;

  const ActivitiesLoadFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class Activity {
  final String user;
  final String activity;
  final DateTime dateTime;

  Activity({required this.user, required this.activity, required this.dateTime});
}
