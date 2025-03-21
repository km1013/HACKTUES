import 'package:flutter/material.dart';
import '../services/credit_card_.dart';
import '../services/transaction.dart';

class SendMoneyScreen extends StatefulWidget {
  final void Function(String title, double amount)? onTransactionAdded;

  const SendMoneyScreen({Key? key, this.onTransactionAdded}) : super(key: key);

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;

  int selectedCardIndex = 0;

 void _sendMoney() {
  double amount = double.tryParse(amountController.text) ?? 0;

  if (amount <= 0) {
    _showSnack("Enter a valid amount");
    return;
  }

  double currentBalance = CreditCardService().getCardBalance(selectedCardIndex);
  if (amount > currentBalance) {
    _showSnack("Insufficient balance on selected card");
    return;
  }

  // Deduct and record transaction
  CreditCardService().deductFromCard(selectedCardIndex, amount);
  TransactionService().send(amount);

  // 🔥 Add transaction to dashboard
if (widget.onTransactionAdded != null) {
  widget.onTransactionAdded!("Sent \$${amount.toStringAsFixed(2)}", amount);
}

  _showSnack("Sent \$${amount.toStringAsFixed(2)}");
  Navigator.pop(context);
}

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final cards = CreditCardService().cards;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: black,
        title: Text("Send Money", style: TextStyle(color: white)),
        leading: BackButton(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Send Money", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: black)),
              SizedBox(height: 20),

              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Amount (\$)", Icons.attach_money),
              ),
              SizedBox(height: 16),

              TextField(
                controller: ibanController,
                decoration: _inputDecoration("IBAN", Icons.credit_card),
              ),
              SizedBox(height: 10),
              Text("or", style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: _inputDecoration("Phone Number", Icons.phone),
              ),
              SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Credit Card", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              DropdownButton<int>(
                isExpanded: true,
                value: selectedCardIndex,
                items: List.generate(cards.length, (index) {
                  final card = cards[index];
                  return DropdownMenuItem(
                    value: index,
                    child: Text("${card.brand} **** ${card.lastDigits} - \$${card.balance.toStringAsFixed(2)}"),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedCardIndex = value!;
                  });
                },
              ),

              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sendMoney,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightGreen,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Send", style: TextStyle(color: white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    );
  }
}