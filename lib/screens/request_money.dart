import 'package:flutter/material.dart';
import '../services/transaction.dart';

class RequestMoneyScreen extends StatefulWidget {
  @override
  _RequestMoneyScreenState createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final TextEditingController amountController = TextEditingController();

  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;

  void _requestMoney() {
    double amount = double.tryParse(amountController.text) ?? 0;

    if (amount <= 0) {
      _showSnack("Enter a valid amount");
      return;
    }

    TransactionService().request(amount);
    _showSnack("Request successful — money received!");
    Navigator.pop(context);
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: black,
        title: Text("Request Money", style: TextStyle(color: white)),
        leading: BackButton(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              "Request Money",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: black),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "\$0.00",
                labelText: "Enter amount",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _requestMoney,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreen,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Request", style: TextStyle(color: white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}