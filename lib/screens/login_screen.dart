import 'package:flutter/material.dart';

import '../controllers/google_auth.dart';
import '../data/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: DISPLAY_SPACING * 6, horizontal: DISPLAY_SPACING * 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/scribble.png'),
            Text(
              'Scribbles',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: LIGHT_TEXT),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isLoading = true;
                });
                signInWithGoogle(context);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Image.asset('assets/images/google.png')),
            ),
          ],
        ),
      ),
    );
  }
}
