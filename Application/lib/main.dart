import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:syaahhospitalsystem/Screens/welcomePage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SYAAH_HospitalApp());
}

class SYAAH_HospitalApp extends StatelessWidget {
  const SYAAH_HospitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

// Ahmed Bagha //
