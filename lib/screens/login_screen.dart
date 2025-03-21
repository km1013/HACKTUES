import 'package:flutter/material.dart';
import '../services/authenticate.dart';
import 'dashboard_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (!AuthService().userExists(email)) {
        _showError("This email is not registered. Please sign up first.");
        return;
      }

      final success = AuthService().login(email, password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardScreen()),
        );
      } else {
        _showError("Incorrect password. Try again.");
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: black,
        title: Text("Log In", style: TextStyle(color: white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Welcome Back!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: black)),
                  SizedBox(height: 8),
                  Text("Log in to your bank account", style: TextStyle(fontSize: 16, color: black.withOpacity(0.6))),
                  SizedBox(height: 32),

                  TextFormField(
                    controller: emailController,
                    decoration: _inputDecoration("Email", Icons.email),
                    validator: (value) => value!.isEmpty ? "Enter your email" : null,
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: _inputDecoration("Password", Icons.lock),
                    validator: (value) => value!.isEmpty ? "Enter your password" : null,
                  ),
                  SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightGreen,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Log In", style: TextStyle(color: white, fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => SignupScreen()),
                      );
                    },
                    child: Text("Don't have an account? Sign up", style: TextStyle(color: lightGreen)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: black),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}