import 'package:cracker_shop/logo_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'landing_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool? isFirstLaunch;

  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final firstLaunch = prefs.getBool('seenIntro') ?? false;
    setState(() {
      isFirstLaunch = !firstLaunch; // true if never seen intro
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstLaunch == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If first time opening → Show intro pages
    if (isFirstLaunch!) {
      return const Logo(); // first intro page
    }

    // If not first time → check Firebase login
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const landing();
        }
        return const login();
      },
    );
  }
}
