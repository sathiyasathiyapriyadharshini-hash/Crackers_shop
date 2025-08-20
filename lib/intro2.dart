import 'package:cracker_shop/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class intro2 extends StatelessWidget {
  const intro2({super.key});

  Future<void> completeIntro(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenIntro', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isLandscape ? 600 : screenSize.width,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const IntroImage(),
                  const SizedBox(height: 20),
                  const Intro2Text(),
                  const SizedBox(height: 30),
                  GetStartedButton(onPressed: () => completeIntro(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IntroImage extends StatelessWidget {
  const IntroImage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;

    return Image.asset(
      "images/int2.jpg",
      width: isLandscape ? screenWidth * 0.6 : screenWidth * 0.9,
      fit: BoxFit.cover,
    );
  }
}

class Intro2Text extends StatelessWidget {
  const Intro2Text({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final fontSize = isLandscape ? 20.0 : 24.0;

    return Text(
      "India’s vibrant cracker tradition,\nreimagined for the digital age.\nDiscover top brands with just a tap.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GetStartedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "GET STARTED",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.whatshot, color: Colors.orange),
        ],
      ),
    );
  }
}
