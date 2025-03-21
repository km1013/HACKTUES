
import 'package:flutter/material.dart';
import '../services/credit_card_.dart';

class SavingsScreen extends StatefulWidget {
  @override
  _SavingsScreenState createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  @override
  Widget build(BuildContext context) {
    final savings = CreditCardService().getSavingsBalance();

    return Scaffold(
      appBar: AppBar(
        title: Text("Savings"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSavingsCard("Total Savings", savings),
            SizedBox(height: 20),
            Text(
              "This reflects the latest savings after transfers.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavingsCard(String label, double amount) {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                "\$${amount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 26, color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
