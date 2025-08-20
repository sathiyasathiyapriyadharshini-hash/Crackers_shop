import 'package:cracker_shop/intro2.dart';
import 'package:cracker_shop/login.dart';
import 'package:flutter/material.dart';

class intro1 extends StatelessWidget {
  const intro1({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const login()),
              );
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back01.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isLandscape ? 600 : double.infinity,
              ),
              child: const Intro1Content(),
            ),
          ),
        ),
      ),
    );
  }
}

class Intro1Content extends StatelessWidget {
  const Intro1Content({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final textSize = isLandscape ? 22.0 : 26.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50, bottom: 40),
          child: Text(
            "No traffic, no tantrums,\njust tap tap and BOOM\ncrackers at your door!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const intro2()),
            );
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text(
            "NEXT",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
