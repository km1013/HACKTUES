import 'package:flutter/material.dart';

class RequestMoneyScreen extends StatefulWidget {
  final void Function(String title, double amount)? onTransactionAdded;

  const RequestMoneyScreen({Key? key, this.onTransactionAdded}) : super(key: key);

  @override
  _RequestMoneyScreenState createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;

  void _requestMoney() {
    double amount = double.tryParse(amountController.text) ?? 0;
    String iban = ibanController.text.trim();
    String phone = phoneController.text.trim();

    if (amount <= 0) {
      _showSnack("Enter a valid amount");
      return;
    }

    if (iban.isEmpty && phone.isEmpty) {
      _showSnack("Enter either IBAN or phone number");
      return;
    }


    if (widget.onTransactionAdded != null) {
      widget.onTransactionAdded!("Requested \$${amount.toStringAsFixed(2)}", amount);
    }

    _showSnack("Requested \$${amount.toStringAsFixed(2)}");
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Request Money", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: black)),
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
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}