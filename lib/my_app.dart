import 'package:flutter/material.dart';

import '../data/constants.dart';
import 'screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext ctx2, Widget? child) {
        final MediaQueryData data = MediaQuery.of(ctx2);
        return MediaQuery(
          data: data.copyWith(
              textScaleFactor: data.textScaleFactor * TEXT_SCALE_FACTOR),
          child: child!,
        );
      },
      title: 'Scribble',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'JustMeAgainDownHere',
            ),
      ),
      home: const LoginScreen(),
    );
  }
}
