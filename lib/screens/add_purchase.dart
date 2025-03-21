import 'package:flutter/material.dart';

class AddPurchaseScreen extends StatefulWidget {
  @override
  _AddPurchaseScreenState createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  final Color lightGreen = Color(0xFF4CAF50);
  final Color black = Colors.black;
  final Color white = Colors.white;
  
  String selectedCategory = 'Entertainment';
  final List<String> categories = [
    'Entertainment', 'Housing', 'Food', 'Bills', 'Transport', 'Health', 'Shopping'
  ];

  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void _savePurchase() {
    if (amountController.text.isEmpty || titleController.text.isEmpty || dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields before confirming!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Purchase Added Successfully!")),
    );

    Navigator.pop(context); // Close the screen after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text('Add Purchase', style: TextStyle(color: black)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Closes the screen
          },
          icon: Icon(Icons.arrow_left)),
        actions: [
          TextButton(
            onPressed: _savePurchase,
            child: Text('Confirm', style: TextStyle(color: Colors.blue, fontSize: 13)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Amount'),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: _buildInputDecoration('\$0.00'),
            ),
            SizedBox(height: 20),

            _buildLabel('Title'),
            TextField(
              controller: titleController,
              decoration: _buildInputDecoration('Name of the purchase'),
            ),
            SizedBox(height: 20),

            _buildLabel('Category'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      child: Text(category, style: TextStyle(color: black)),
                      value: category,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),

            _buildLabel('Date'),
            TextField(
              controller: dateController,
              decoration: _buildInputDecoration('Select Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                  });
                }
              },
              readOnly: true,
            ),
            SizedBox(height: 40),

            // Save Purchase Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _savePurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreen,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Save Purchase", style: TextStyle(color: white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black)),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      hintText: hintText,
      hintStyle: TextStyle(color: black.withOpacity(0.6)),
    );
  }
}