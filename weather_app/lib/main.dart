import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/views/HomeView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              fontSize: 75,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
          headlineMedium: TextStyle(
              fontSize: 30, color: Theme.of(context).primaryColorDark),
          headlineSmall:
              const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeView(),
    );
  }
}
