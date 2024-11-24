import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phenom2025/pages/splash.dart';
import 'package:phenom2025/provider/provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDQfeS-W1tlBFuhXT63IKW-6grJP-GERrA',
      appId: "1:659729425136:android:5922c0288d0ee8b2819835",
      messagingSenderId: "659729425136",
      projectId: "phenom2025-13186",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (BuildContext builderContext) {
            return const Splash();
          },
        ),
      ),
    );
  }
}
