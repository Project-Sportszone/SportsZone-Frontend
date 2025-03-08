import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.5;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), 
    );

    
    _startAnimation();
    _navigateToLogin();
  }

  _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; 
        _scale = 1.0; 
      });
    });
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacementNamed(context, '/login');
      context.go('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1), 
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 1), 
            curve: Curves.easeInOut, 
            child: Image.asset(
              'assets/images/sportszone.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
