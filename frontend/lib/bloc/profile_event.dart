import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateEmail extends ProfileEvent {
  final String newEmail;

  const UpdateEmail(this.newEmail);

  @override
  List<Object> get props => [newEmail];
}
