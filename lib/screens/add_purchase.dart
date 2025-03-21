import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddPurchaseScreen(),
    );
  }
}

class AddPurchaseScreen extends StatefulWidget {
  @override
  _AddPurchaseScreenState createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  String selectedCategory = 'Entertainment';
  final List<String> categories = [
    'Entertainment', 'Housing', 'Food', 'Bills', 'Transport', 'Health', 'Shopping'
  ];

  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Add Purchase', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {},
          child: Text('Cancel', style: TextStyle(color: Colors.blue)),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Confirm', style: TextStyle(color: Colors.blue)),
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
                color: Colors.grey[300],
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
                      child: Text(category),
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
              decoration: _buildInputDecoration('Date'),
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
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: TextStyle(fontSize: 16));
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[300],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      hintText: hintText,
    );
  }
}