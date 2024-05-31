import 'package:digital_notebook/account/blocs/signup_bloc/authentication_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
  builder: (context, state) {
    if (state is PageLoading) {
      return const CircularProgressIndicator(); // Show a loading spinner
    } else if (state is PageLoaded) {
      return const Text('Page Loaded'); // Show some content
    } else {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Echo',
            style: GoogleFonts.dancingScript(
              textStyle: TextStyle(
                color: Colors.red[500],
                fontSize: 50,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/quill.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),

          Positioned(
            top: 400,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Put your notes \n                  here',
                style: GoogleFonts.dancingScript(
                  textStyle: TextStyle(
                    color: Colors.red[500],
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 500,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size> (const Size(150, 50)),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blueGrey.withOpacity(0.9);
                    }
                    return Colors.white;
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(180),
                    side: const BorderSide(color: Colors.blueGrey, width: 2),
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(5),
                shadowColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
              ),
              child: const Text(
                'Register Here',
                style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w300, fontSize:18
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Click Here',
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/adminLogin');
                                }
                            ),
                          const TextSpan(
                            text: " for Admin",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]
      )
    );
  }
  }
  );
  }
}