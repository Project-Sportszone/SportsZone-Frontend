import 'package:flutter/material.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/onboarding_screen.dart';
import 'package:frontend/view/signup_screen.dart';
import 'package:frontend/view/splash_screen.dart';
import 'package:go_router/go_router.dart';



final GoRouter routers = GoRouter(

  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>  SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) =>   const LoginScreen(),
    ),
        GoRoute(
      path: '/signup',
      builder: (context, state) =>   const SignupScreen(),
    ),
          GoRoute(
      path: '/onboard',
      builder: (context, state) =>   const Onboarding(),
    ),
  
  ],
);
