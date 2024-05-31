import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController email;

  const EmailField({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const Text('Email'),
    //     const SizedBox(
    //       height: 10,
    //     ),
        return Container(
            alignment: Alignment.centerLeft,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.grey[800],
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'San Serif',
                    fontSize: 16,
                    color:Colors.black),
                ));

  }
}
