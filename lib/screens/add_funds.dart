
import 'package:flutter/material.dart';
import '../services/credit_card_.dart';

class AddFundsScreen extends StatefulWidget {
  @override
  _AddFundsScreenState createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {
  final _amountController = TextEditingController();
  String? _source;
  String? _destination;

  @override
  Widget build(BuildContext context) {
    final cards = CreditCardService().cards;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Funds'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _source,
              decoration: InputDecoration(labelText: 'From'),
              items: [
                DropdownMenuItem(value: 'savings', child: Text('Savings')),
                ...cards.asMap().entries.map((entry) {
                  return DropdownMenuItem(
                    value: 'card_${entry.key}',
                    child: Text('Card: ${entry.value.brand} ****${entry.value.lastDigits}'),
                  );
                }),
              ],
              onChanged: (value) {
                setState(() => _source = value);
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _destination,
              decoration: InputDecoration(labelText: 'To'),
              items: [
                ...cards.asMap().entries.map((entry) {
                  return DropdownMenuItem(
                    value: 'card_${entry.key}',
                    child: Text('Card: ${entry.value.brand} ****${entry.value.lastDigits}'),
                  );
                }),
                DropdownMenuItem(value: 'savings', child: Text('Savings')),
              ],
              onChanged: (value) {
                setState(() => _destination = value);
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount', prefixText: '\$'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _transferFunds,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }

  void _transferFunds() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0 || _source == null || _destination == null) {
      _showSnack("Please fill in all fields with valid data");
      return;
    }

    if (_source == _destination) {
      _showSnack("Source and destination must be different");
      return;
    }

    final service = CreditCardService();

    // Savings ➡️ Card
    if (_source == 'savings' && _destination!.startsWith('card_')) {
      int cardIndex = int.parse(_destination!.split('_')[1]);
      if (service.savings >= amount) {
        service.deductFromSavings(amount);
        service.addToCard(cardIndex, amount);
      } else {
        _showSnack("Insufficient savings");
        return;
      }
    }

    // Card ➡️ Savings
    else if (_destination == 'savings' && _source!.startsWith('card_')) {
      int cardIndex = int.parse(_source!.split('_')[1]);
      if (service.getCardBalance(cardIndex) >= amount) {
        service.deductFromCard(cardIndex, amount);
        service.addToSavings(amount);
      } else {
        _showSnack("Insufficient card balance");
        return;
      }
    }

    // Card ➡️ Card
    else if (_source!.startsWith('card_') && _destination!.startsWith('card_')) {
      int fromIndex = int.parse(_source!.split('_')[1]);
      int toIndex = int.parse(_destination!.split('_')[1]);
      if (fromIndex == toIndex) {
        _showSnack("Cannot transfer to the same card");
        return;
      }
      if (service.getCardBalance(fromIndex) >= amount) {
        service.deductFromCard(fromIndex, amount);
        service.addToCard(toIndex, amount);
      } else {
        _showSnack("Insufficient card balance");
        return;
      }
    } else {
      _showSnack("Invalid transfer combination");
      return;
    }

    _showSnack("Funds transferred successfully");
    Navigator.pop(context);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
