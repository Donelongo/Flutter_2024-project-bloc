import 'package:digital_notebook/models/activity_model.dart';
import 'package:equatable/equatable.dart';

class ActivityLogState extends Equatable {
  const ActivityLogState();

  @override
  List<Object> get props => [];
}

class ActivitiesLogInitial extends ActivityLogState {}
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

