import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    if (!mounted) return;
    if (seenOnboarding) {
      context.go('/products');
    } else {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrQUGK1WFDkCgDTfJwVXramAUaQRkg71GdrA&s',
        width: 120,
        height: 120,
      ),),
    );
  }
}
