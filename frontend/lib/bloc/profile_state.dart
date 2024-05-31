import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String email;

  const ProfileState(this.email);

  @override
  List<Object?> get props => [email];
}
