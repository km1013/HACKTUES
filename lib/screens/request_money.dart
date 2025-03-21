import 'package:flutter/material.dart';

class RequestMoneyScreen extends StatefulWidget {
  @override
  _RequestMoneyScreenState createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;

  void _requestMoney() {
    if (ibanController.text.isEmpty && phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter IBAN or Phone Number")),
      );
      return;
    }
    // Request money logic (API call, notifications, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Money Request Sent!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text("Request Money", style: TextStyle(color: white)),
        backgroundColor: black,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Request Money",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: black),
            ),
            SizedBox(height: 20),

            // IBAN Input
            TextField(
              controller: ibanController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Enter IBAN",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),

            // OR Divider
            Row(
              children: [
                Expanded(child: Divider(color: black, thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("OR", style: TextStyle(color: black, fontWeight: FontWeight.bold)),
                ),
                Expanded(child: Divider(color: black, thickness: 1)),
              ],
            ),
            SizedBox(height: 20),

            // Phone Number Input
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Enter Phone Number",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 30),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _requestMoney,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreen,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Confirm", style: TextStyle(color: white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}