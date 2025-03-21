import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  final double netIncome = 2500.00;
  final double income = 3500.00;
  final double expenses = 1000.00;
  final double entertainment = 200.00;
  final double housing = 500.00;
  final double groceries = 300.00;

  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text("Budget Overview", style: TextStyle(color: white)),
        backgroundColor: black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Net Income Card
              _buildBudgetCard(
                "Net Income",
                netIncome,
                lightGreen,
                Icons.account_balance_wallet,
              ),
              SizedBox(height: 15),

              // Income & Expenses Section
              Row(
                children: [
                  Expanded(
                    child: _buildBudgetCard(
                      "Income",
                      income,
                      Colors.green,
                      Icons.attach_money,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildBudgetCard(
                      "Expenses",
                      -expenses,
                      Colors.red,
                      Icons.money_off,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Expenses Breakdown Title
              Text(
                "Expenses Breakdown",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
              ),
              SizedBox(height: 10),

              // Expense Breakdown Cards
              _buildExpenseCard("Entertainment", -entertainment, Icons.movie),
              _buildExpenseCard("Housing", -housing, Icons.home),
              _buildExpenseCard("Groceries", -groceries, Icons.shopping_cart),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetCard(String title, double amount, Color color, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 30, color: color),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "\$${amount.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCard(String title, double amount, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Row(
          children: [
            Icon(icon, size: 26, color: black),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
              ),
            ),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}