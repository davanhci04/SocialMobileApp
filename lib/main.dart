import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/auth/presentation/pages/auth_page.dart';
import 'package:untitled/config/firebase_options.dart';
import 'package:untitled/themes/light_mode.dart';

import 'app.dart';

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}
// run app

