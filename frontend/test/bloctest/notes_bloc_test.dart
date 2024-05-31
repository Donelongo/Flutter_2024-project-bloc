// import 'package:bloc_test/bloc_test.dart';
// import 'package:digital_notebook/bloc/notes_bloc.dart';
// import 'package:digital_notebook/bloc/notes_event.dart';
// import 'package:digital_notebook/bloc/notes_state.dart';

// blocTest<NotesBloc, NotesState>(
//   'emits [NotesLoading, NotesLoaded] when successful',
//   build: () => NotesBloc(),
//   act: (bloc) => bloc.add(FetchNotes()),
//   expect: () => [NotesLoading(), NotesLoaded()],
// );