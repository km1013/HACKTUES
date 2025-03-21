import 'package:flutter/material.dart';
import '../services/authenticate.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      AuthService().register(emailController.text.trim(), passwordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created. Please log in.')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: black,
        title: Text("Create Account", style: TextStyle(color: white)),
        leading: BackButton(color: white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Create Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: black)),
                  SizedBox(height: 8),
                  Text("Sign up to get started", style: TextStyle(fontSize: 16, color: black.withOpacity(0.6))),
                  SizedBox(height: 32),

                  TextFormField(
                    controller: emailController,
                    decoration: _inputDecoration("Email", Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty || !value.contains('@') ? "Enter a valid email" : null,
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: passwordController,
                    decoration: _inputDecoration("Password", Icons.lock),
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 6 ? "Password must be at least 6 characters" : null,
                  ),
                  SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightGreen,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Sign Up", style: TextStyle(color: white, fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Text("Already have an account? Log In", style: TextStyle(color: lightGreen)),
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
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    );
  }
}