import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  final double netIncome = 0;
  final double income = 0;
  final double expenses = 0;
  final double entertainment = 0;
  final double housing = 0;
  final double groceries = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget App"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBudgetCard("Net income", netIncome, Colors.green),
            SizedBox(height: 15),
            _buildBudgetCard("Income", income, Colors.green),
            _buildBudgetCard("Expenses", -expenses, Colors.red),
            SizedBox(height: 15),
            Text(
              "Expenses Breakdown:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildExpenseCard("Entertainment", -entertainment),
            _buildExpenseCard("Housing", -housing),
            _buildExpenseCard("Groceries", -groceries),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCard(String title, double amount, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCard(String title, double amount) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}