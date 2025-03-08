import 'package:flutter/material.dart';
import 'package:frontend/routes/route.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routers,
      debugShowCheckedModeBanner: false,
    );
  }
}
