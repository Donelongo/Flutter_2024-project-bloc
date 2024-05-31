// ignore_for_file: deprecated_member_use, constant_identifier_names
import 'package:digital_notebook/account/blocs/signup_bloc/authentication_bloc.dart';
import 'package:digital_notebook/account/blocs/signup_bloc/signup_bloc/signup_bloc.dart';
import 'package:digital_notebook/bloc/activity_log_bloc.dart';
import 'package:digital_notebook/bloc/add_note_bloc.dart';
import 'package:digital_notebook/bloc/note_view_bloc.dart';
import 'package:digital_notebook/bloc/notes_bloc.dart';
import 'package:digital_notebook/presentation/screens/addnotes.dart';
import 'package:digital_notebook/presentation/screens/update_profile.dart';
import 'package:digital_notebook/services/notes_api_service.dart';
import 'package:flutter/material.dart';
import 'package:digital_notebook/presentation/screens/home.dart';
import 'package:digital_notebook/presentation/screens/admin/admin.dart';
import 'package:digital_notebook/presentation/screens/admin/adminLogin.dart';
import 'package:digital_notebook/presentation/screens/admin/adminAddNotes.dart';
import 'package:digital_notebook/presentation/screens/admin/adminOthers.dart';
import 'package:digital_notebook/presentation/screens/login.dart';
import 'package:digital_notebook/presentation/screens/signup.dart';
import 'package:digital_notebook/presentation/screens/notes.dart';
import 'package:digital_notebook/presentation/screens/others.dart';
import 'package:digital_notebook/presentation/screens/admin/manage_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum ThemeModeOption {
  white,
  Sepia,
  dark,
}

void main() {
  final NotesApiService apiService = NotesApiService();
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatefulWidget {
  final NotesApiService apiService;

  const MyApp({super.key, required this.apiService});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeModeOption currentThemeMode = ThemeModeOption.white;
  final GoRouter _router = GoRouter(routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/admin', builder: (context, state) => const AdminPage()),
    GoRoute(path: '/other', builder: (context, state) => const ViewOtherNotesPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(path: '/notes', builder: (context, state) => const Notepage()),
    GoRoute(path: '/adminLogin', builder: (context, state) => const AdminLoginPage()),
    GoRoute(path: '/adminAddNotes', name: 'adminAddNotes', builder: (context, state) => const AdminAddNotepage()),
    GoRoute(path: '/adminOthers', builder: (context, state) => const AdminOthersPage()),
    GoRoute(path: '/addNote', name: 'addNote',builder: (context, state) => const AddNote()),
    GoRoute(path: '/updateProfile', builder: (context, state) => UpdateProfilePage()),
    GoRoute(path: '/manageUser', builder: (context, state) => const ManageUsersPage()),
  ]);

  @override
  Widget build(BuildContext context) {
    buildThemeData();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => AddNoteBloc()),
        BlocProvider(create: (context) => NotesBloc(widget.apiService)..add(GiveMeData())),
        BlocProvider(create: (context) => NoteViewBloc()),
        BlocProvider(create: (context) => ActivityLogBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: currentThemeMode == ThemeModeOption.dark
            ? ThemeMode.dark
            : ThemeMode.light,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
          ),
        ),
        darkTheme: ThemeData.dark(),
        routerConfig: _router,
      ),
    );
  }

  ThemeData buildThemeData() {
    switch (currentThemeMode) {
      case ThemeModeOption.white:
        return ThemeData.light().copyWith(
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(fontFamily: 'Mate'),
                bodyMedium: const TextStyle(fontFamily: 'Mate'),
              ),
        );
      case ThemeModeOption.Sepia:
        return ThemeData.light().copyWith(
          scaffoldBackgroundColor:
              const Color.fromARGB(255, 189, 148, 128), // Sepia color
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 189, 148, 128), // Sepia color
            titleTextStyle: TextStyle(color: Colors.grey, fontFamily: 'Mate'),
            iconTheme: IconThemeData(color: Colors.grey),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.grey, fontFamily: 'Mate'),
            bodyMedium: TextStyle(color: Colors.grey, fontFamily: 'Mate'),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white, fontFamily: 'Mate'),
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Mate'),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 189, 148, 128), // Sepia color
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.grey,
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
              color: Color.fromARGB(255, 189, 148, 128)), // Sepia color
        );
      case ThemeModeOption.dark:
        return ThemeData.dark().copyWith(
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(fontFamily: 'Mate'),
                bodyMedium: const TextStyle(fontFamily: 'Mate'),
              ),
        );
    }
  }

  void changeThemeMode(ThemeModeOption newThemeMode) {
    setState(() {
      currentThemeMode = newThemeMode;
    });
  }
}
