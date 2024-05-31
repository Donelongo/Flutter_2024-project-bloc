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
