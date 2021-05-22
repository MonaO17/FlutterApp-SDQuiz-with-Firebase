import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/screens/welcome/welcome_screen.dart';

void main() {
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [Locale('de', 'DE'), Locale('en', 'US')],
      fallbackLocale: Locale('de', 'DE'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: 'Quiz',
      debugShowCheckedModeBanner:false ,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}
