import 'package:flutter/material.dart';

class PasswordWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final ValueNotifier<bool> obscureTextNotifier = ValueNotifier(true);

  PasswordWidget({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: obscureTextNotifier,
          builder: (context, obscureText, child) {
            return TextFormField(
              controller: passwordController,
              obscureText: obscureText,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    obscureTextNotifier.value = !obscureTextNotifier.value;
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }
}
