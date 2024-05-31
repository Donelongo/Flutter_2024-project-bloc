// import 'package:digital_notebook/bloc/notes_bloc.dart';
// import 'package:bloc_test/bloc_test.dart';

// void main() {
//   blocTest<NotesBloc, NotesState>(
//     'emits [NotesLoading, NotesLoaded] when successful',
//     build: () => NotesBloc(),
//     act: (bloc) => bloc.add(GiveMeData()),
//     expect: () => [NotesLoading(), const NotesLoaded()],
//   );

//   blocTest<NotesBloc, NotesState>(
//     'emits [NotesLoading, NotesError] when unsuccessful',
//     build: () => NotesBloc(),
//     act: (bloc) => bloc.add(GiveMeData()),
//     expect: () => [NotesLoading(), const NotesError()],
//   );
// }