import 'package:flutter/material.dart';

import '/../utils/constants.dart';
import '../secondary screens/add_transaction_screen.dart';
import '/../widgets/text_field_input.dart';

class Transaction {
  final String id;
  final String type;
  String description;
  double amount;
  DateTime date;

  Transaction({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    required this.date,
  });
}

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _searchQuery = '';
  String _filterType = 'all';
  String _selectedCategory = 'All';

  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      type: 'income',
      description: 'Salary',
      amount: 5000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      type: 'expense',
      description: 'Groceries',
      amount: -150,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      type: 'income',
      description: 'Freelance',
      amount: 300,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      type: 'transfer',
      description: 'Savings',
      amount: 200,
      date: DateTime.now(),
    ),
  ];

  void _filterTransactions(String type) {
    if (_filterType != type) {
      setState(() {
        _filterType = type;
      });
    } else {
      setState(() {
        _filterType = 'all';
      });
    }
  }

  List<Transaction> get _filteredTransactions {
    return _transactions.where((tx) {
      if (_filterType != 'all' && tx.type != _filterType) {
        return false;
      }
      if (_searchQuery.isNotEmpty &&
          !tx.description.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  final List<String> _categories = ['All', 'Income', 'Expense', 'Transfer'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: TextFieldInput(
                      hintText: 'Search',
                      icon: const Icon(Icons.search),
                      textInputType: TextInputType.text,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 40,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 5,
                          // offset: const Offset(1.5, 2),
                        ),
                      ],
                    ),
                    height: 40,
                    padding: const EdgeInsets.fromLTRB(9, 0, 5, 0),
                    child: Center(
                      child: DropdownButton<String>(
                        alignment: AlignmentDirectional.centerStart,
                        isDense: true,
                        elevation: 2,
                        dropdownColor: Colors.white,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(8),
                        value: _selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                          });
                        },
                        items: _categories
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _filterTransactions('income'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          _filterType == 'income'
                              ? Colors.greenAccent[700]
                              : Colors.greenAccent[400]),
                      shadowColor: WidgetStateProperty.all(Colors.greenAccent),
                      elevation: WidgetStateProperty.all(
                        _filterType == 'income' ? 5 : 0,
                      ),
                    ),
                    child: const Text(
                      'Income',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _filterTransactions('expense'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          _filterType == 'expense'
                              ? Colors.greenAccent[700]
                              : Colors.greenAccent[400]),
                      shadowColor: WidgetStateProperty.all(Colors.greenAccent),
                      elevation: WidgetStateProperty.all(
                        _filterType == 'expense' ? 5 : 0,
                      ),
                    ),
                    child: const Text(
                      'Expense',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _filterTransactions('transfer'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          _filterType == 'transfer'
                              ? Colors.greenAccent[700]
                              : Colors.greenAccent[400]),
                      shadowColor: WidgetStateProperty.all(Colors.greenAccent),
                      elevation: WidgetStateProperty.all(
                        _filterType == 'transfer' ? 5 : 0,
                      ),
                    ),
                    child: const Text(
                      'Transfer',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredTransactions.length,
                  itemBuilder: (ctx, index) {
                    final tx = _filteredTransactions[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      shadowColor: Colors.greenAccent[150],
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(tx.description),
                        subtitle: Text('\$${tx.amount.toStringAsFixed(2)}'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Date: ${tx.date.toString().split(' ')[0]}'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _showUpdateDialog(tx);
                                },
                                child: const Text('Update'),
                              ),
                              TextButton(
                                onPressed: () => _showDeleteDialog(tx.id),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddTransactionScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showUpdateDialog(Transaction tx) {
    final TextEditingController descriptionController =
        TextEditingController(text: tx.description);
    final TextEditingController amountController =
        TextEditingController(text: tx.amount.toString());
    final TextEditingController dateController =
        TextEditingController(text: tx.date.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: scaffoldBackgroundColor,
          title: const Text('Update Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldInput(
                textEditingController: descriptionController,
                hintText: 'Description',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: amountController,
                hintText: 'Amount',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: dateController,
                hintText: 'Date',
                textInputType: TextInputType.datetime,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: tx.date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      dateController.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tx.description = descriptionController.text;
                  tx.amount = double.tryParse(amountController.text) ?? 0.0;
                  tx.date = DateTime.parse(dateController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: scaffoldBackgroundColor,
          title: const Text('Delete Transaction'),
          content:
              const Text('Are you sure you want to delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () {
                _deleteTransaction(id);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
