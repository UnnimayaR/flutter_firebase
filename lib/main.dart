import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase_options.dart';
import 'package:get/get.dart';
import 'screens/auth_screen.dart';
import 'screens/verify_otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Auth App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => AuthScreen()),
        GetPage(name: '/verify', page: () => VerifyOTPScreen()),
      ],
    );
  }
}
