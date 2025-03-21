
import 'package:flutter/material.dart';
import '../services/credit_card_.dart';
import '../services/transaction.dart';
import 'send_money.dart';
import 'request_money.dart';
import 'budget.dart';
import 'add_purchase.dart';
import 'savings.dart';
import 'add_funds.dart';

void main() {
  runApp(DashboardScreen());
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      routes: {
        '/request': (context) => RequestMoneyScreen(),
        '/send': (context) => SendMoneyScreen(),
        '/budget': (context) => BudgetScreen(),
        '/add_purchase': (context) => AddPurchaseScreen(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  static List<Map<String, dynamic>> transactions = [];

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isMenuOpen = false;
  int _cardIndex = 0;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _switchCard() {
    setState(() {
      _cardIndex = (_cardIndex + 1) % CreditCardService().cards.length;
    });
  }

  void _onMenuItemSelected(String item) {
    setState(() {
      _isMenuOpen = false;
    });

    if (item == 'Add Purchase') {
      Navigator.pushNamed(context, '/add_purchase');
    } else if (item == 'Budget') {
      Navigator.pushNamed(context, '/budget');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cards = CreditCardService().cards;
    final currentCard = cards[_cardIndex];
    final savings = CreditCardService().getSavingsBalance();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 80),
              Align(
                alignment: Alignment.topLeft,
                child: !_isMenuOpen
                    ? Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.menu, size: 30),
                            onPressed: _toggleMenu,
                          ),
                          Text("Cash", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                          Text("Mate", style: TextStyle(color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      )
                    : SizedBox(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _switchCard,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: BalanceCard(
                    key: ValueKey(_cardIndex),
                    balance: "\$${currentCard.balance.toStringAsFixed(2)}",
                    lastDigits: currentCard.lastDigits,
                    color: _cardIndex == 0 ? Colors.green : Colors.black,
                    cardholder: _cardIndex == 0 ? "Ruslan Nikolov" : "Simeon Simeonov",
                    brand: currentCard.brand,
                    offset: 50,
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: Size(120, 50)),
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/request');
                      setState(() {});
                    },
                    child: Text("Request"),
                  ),
                  SizedBox(width: 20),
                    ElevatedButton(
                    onPressed: () async {
                    await Navigator.push(
                  context,
                   MaterialPageRoute(builder: (_) => AddFundsScreen()),
                   
                   );
                  setState(() {}); // Refresh after funds transfer
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AddFundsScreen()));
                   },
                  style: ElevatedButton.styleFrom(minimumSize: Size(120, 50)),
                  child: Text("Add"),
             

                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: Size(120, 50)),
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/send');
                      setState(() {});
                    },
                    child: Text("Send"),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Transaction History", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...MainPage.transactions.reversed.map((txn) {
                      return ListTile(
                        leading: Icon(Icons.call_made, color: Colors.red),
                        title: Text(txn['title']),
                        subtitle: Text("Sent on ${DateTime.now().toLocal().toString().split(' ')[0]}"),
                        trailing: Text("-\$${txn['amount'].toStringAsFixed(2)}", style: TextStyle(color: Colors.red)),
                      );
                    }).toList(),
                    ListTile(
                      title: Text("Income: \$3500.00 "),
                    ),
                    ListTile(
                      title: Text("Expenses: \$${TransactionService().expenses.toStringAsFixed(2)}"),
                )],
                ),
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: _isMenuOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: Container(
              width: 250,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    onTap: () => setState(() => _isMenuOpen = false),
                  ),
                  ListTile(
                    leading: Icon(Icons.sports_basketball),
                    title: Text("Add Purchase"),
                    onTap: () => _onMenuItemSelected('Add Purchase'),
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_basket),
                    title: Text("Budget"),
                    onTap: () => _onMenuItemSelected('Budget'),
                  ),
                  ListTile(
                   leading: Icon(Icons.savings),
                  title: Text("Savings"),
                  onTap: () {
                  Navigator.push(
                  context,
                   MaterialPageRoute(builder: (_) => SavingsScreen()),
                  );
                },  
              ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String balance;
  final String lastDigits;
  final Color color;
  final String cardholder;
  final String brand;
  final double offset;

  const BalanceCard({
    Key? key,
    required this.balance,
    required this.lastDigits,
    required this.color,
    required this.cardholder,
    required this.brand,
    required this.offset,
  }) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    final savings = CreditCardService().getSavingsBalance();
    return Container(
      width: 320,
      height: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(brand, style: TextStyle(color: Colors.white, fontSize: 18)),
          Spacer(),
          Text(balance, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("**** $lastDigits", style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 4),
          Text(cardholder, style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
