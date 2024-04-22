import 'package:fcx_app/configurations/FutureProvider.dart';
import 'package:fcx_app/pages/login_page.dart';
import 'package:fcx_app/pages/profile_page.dart';
import 'package:fcx_app/pages/signup_page2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());
    runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FutureCertX()),
    
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: SignUpPage2(),
    );
  }
}
