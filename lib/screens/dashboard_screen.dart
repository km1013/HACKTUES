import 'package:flutter/material.dart';
import 'send_money.dart';
import 'request_money.dart';
import 'budget.dart';
import 'add_purchase.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color lightGreen = Color(0xFF4CAF50); // Light green accent
  final Color black = Colors.black;
  final Color white = Colors.white;

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text("Finance App", style: TextStyle(color: white)),
        backgroundColor: black,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: white), // Menu icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Opens the navigation drawer
                
                
              },
            );
          },
        ),
      ),
      
      drawer: Drawer(
        backgroundColor: white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: black),
              child: Center(
                child: Text(
                  "Menu",
                  style: TextStyle(color: white, fontSize: 24),
                ),
              ),
            ),
            _drawerItem(Icons.home, "Home", () {}),
            _drawerItem(Icons.shopping_basket, "Add Purchase", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>AddPurchaseScreen()),
              );
            }),
            _drawerItem(Icons.bar_chart, "Budget", (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BudgetScreen()),
              );
            }),
            _drawerItem(Icons.savings, "Savings", () {}),
            _drawerItem(Icons.settings, "Settings", () {}),
            
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Balance Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Balance", style: TextStyle(color: white, fontSize: 16)),
                  SizedBox(height: 5),
                  Text("\$0.00", style: TextStyle(color: white, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Card Brand", style: TextStyle(color: white, fontSize: 14)),
                      Text("**** 1234", style: TextStyle(color: white, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Request & Send Buttons
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendMoneyScreen()), // Navigate correctly
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF4CAF50), // Light Green
    padding: EdgeInsets.symmetric(horizontal:40, vertical:-14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  child: Text("Send", style: TextStyle(color: Colors.white, fontSize: 16)),
),

ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestMoneyScreen()), // Navigate correctly
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF4CAF50), // Light Green
    padding: EdgeInsets.symmetric(horizontal:30, vertical:-14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  child: Text("Request", style: TextStyle(color: Colors.white, fontSize: 16)),
),


            

            // Most Recent Transactions
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Most recent", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black)),
            ),
            SizedBox(height: 10),

            _transactionItem(Icons.shopping_cart, "Shopping", "\$50.00"),
            _transactionItem(Icons.sports_basketball, "Basketball", "\$20.00"),
          ],
        ),
      ),
    );
  }

  // Drawer Menu Item
  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: black),
      title: Text(title, style: TextStyle(color: black, fontSize: 16)),
      onTap: onTap,
    );
  }

  // Transaction Item
  Widget _transactionItem(IconData icon, String title, String amount) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 30, color: black),
        title: Text(title, style: TextStyle(color: black)),
        trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold, color: black)),
      ),
    );
    
  }
}
