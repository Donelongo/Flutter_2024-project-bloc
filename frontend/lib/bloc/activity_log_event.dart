import 'package:equatable/equatable.dart';

abstract class ActivityLogEvent extends Equatable {
  const ActivityLogEvent();

  @override
  List<Object> get props => [];
}

class AddActivityEvent extends ActivityLogEvent {
  final String user;
  final String activity;
  final DateTime dateTime;

  const AddActivityEvent({required this.user, required this.activity, required this.dateTime});

  @override
  List<Object> get props => [user, activity, dateTime];
}

class LoadActivitiesEvent extends ActivityLogEvent {}

class DeleteActivityEvent extends ActivityLogEvent {
  final int activityId;

  const DeleteActivityEvent({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class UpdateActivityEvent extends ActivityLogEvent {
  final int activityId;
  final String user;
  final String activity;
  final DateTime dateTime;

  const UpdateActivityEvent({required this.activityId, required this.user, required this.activity, required this.dateTime});

  @override
  List<Object> get props => [activityId, user, activity, dateTime];
}