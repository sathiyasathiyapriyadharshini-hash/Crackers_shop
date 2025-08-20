import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'landing_page.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _LoginPageState();
}

class _LoginPageState extends State<login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _error = "";

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _error = "";
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // ✅ Navigate to Landing Page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const landing()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() => _error = e.message ?? "Login failed.");
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("images/loginback.jpg", fit: BoxFit.cover),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: "Email"),
                        validator: (value) =>
                            value!.isEmpty || !value.contains("@") ? "Enter valid email" : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (value) => value!.length < 6 ? "Minimum 6 characters" : null,
                      ),
                      if (_error.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(_error, style: const TextStyle(color: Colors.red)),
                      ],
                      const SizedBox(height: 20),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _login,
                              child: const Text("Login"),
                            ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const registerPage()),
                          );
                        },
                        child: const Text("Don't have an account? Register"),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}     