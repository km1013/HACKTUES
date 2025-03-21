import 'package:flutter/material.dart';
import '../services/authenticate.dart';
import '../screens/login_screen.dart'; // update this path if different

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to log out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            AuthService().logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
            );
          },
          child: Text("Log Out", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}