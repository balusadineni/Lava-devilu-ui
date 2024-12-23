import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  final String userId;
  final String token;

  AddTransactionScreen({required this.userId, required this.token});

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  List<Map<String, dynamic>> _transactions = [
    {'amount': '', 'tags': []}
  ];

  final List<String> _availableTags = [
    'Groceries',
    'Rent',
    'Utilities',
    'Travel',
    'Dining',
    'Entertainment',
    'Education',
    'Health',
  ];

  String _searchTag = '';
  List<String> _filteredTags = [];

  @override
  void initState() {
    super.initState();
    _filteredTags = _availableTags;
  }

  void _addTransactionField() {
    setState(() {
      _transactions.add({'amount': '', 'tags': []});
    });
  }

  void _removeTransactionField(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  void _submitTransactions() {
    final List<Map<String, dynamic>> collectedTransactions =
        _transactions.map((transaction) {
      return {
        'amount': double.tryParse(transaction['amount'] ?? '0'),
        'tags': transaction['tags']
      };
    }).toList();

    print('Submitting transactions: $collectedTransactions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Transactions',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
              SizedBox(height: 16.0),

              // List of transaction fields
              ..._transactions.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> transaction = entry.value;

                return Container(
                  width: 600, // Set a fixed width for the card
                  height: 500,
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 50.0),
                          // Amount Field
                          TextFormField(
                            initialValue: transaction['amount'],
                            decoration:
                                InputDecoration(labelText: 'Amount (float)'),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              _transactions[index]['amount'] = value;
                            },
                          ),
                          SizedBox(height: 20.0),

                          // Tags Input
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchTag = value;
                                _filteredTags = _availableTags
                                    .where((tag) =>
                                        tag.toLowerCase().contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Search or Add Tag',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),

                          // Tag Suggestions
                          if (_searchTag.isNotEmpty)
                            Container(
                              constraints: BoxConstraints(maxHeight: 150),
                              child: ListView(
                                shrinkWrap: true,
                                children: _filteredTags.map((tag) {
                                  return ListTile(
                                    title: Text(tag),
                                    onTap: () {
                                      setState(() {
                                        if (!_transactions[index]['tags']
                                            .contains(tag)) {
                                          _transactions[index]['tags'].add(tag);
                                        }
                                        _searchTag = '';
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),

                          // Tags Display
                          SizedBox(height: 8.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: transaction['tags']
                                .map<Widget>((tag) => Chip(
                                      label: Text(tag),
                                      backgroundColor: Colors.red,
                                      deleteIcon: Icon(Icons.close),
                                      onDeleted: () {
                                        setState(() {
                                          _transactions[index]['tags']
                                              .remove(tag);
                                        });
                                      },
                                    ))
                                .toList(),
                          ),
                          SizedBox(height: 16.0),

                          // Remove Button
                          if (_transactions.length > 1)
                            TextButton(
                              onPressed: () => _removeTransactionField(index),
                              child: Text('Remove Transaction'),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              // Add Another Transaction Button
              ElevatedButton(
                onPressed: _addTransactionField,
                child: Text('Add Another Transaction'),
              ),
              SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: _submitTransactions,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

