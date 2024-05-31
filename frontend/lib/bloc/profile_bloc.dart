import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_notebook/bloc/profile_event.dart';
import 'package:digital_notebook/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState('example@example.com'));

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateEmail) {
      yield ProfileState(event.newEmail);
    }
  }
}
