import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/../widgets/button.dart';
import '/../widgets/text_field_input.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  String _transactionType = 'Income';
  String _category = 'Cat 1';
  String _repeat = 'Never';

  @override
  void initState() {
    super.initState();
    _dateController =
        TextEditingController(text: "${DateTime.now()}".split(' ')[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldInput(
                textEditingController: _titleController,
                hintText: 'Title',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                textEditingController: _amountController,
                hintText: "Amount",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      TextFieldInput(
                        width: 200,
                        textEditingController: _dateController,
                        hintText: 'Date',
                        textInputType: TextInputType.datetime,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _dateController.text.isEmpty
                                ? DateFormat('yyyy-MM-dd')
                                    .parse("${DateTime.now()}".split(' ')[0])
                                : DateFormat('yyyy-MM-dd')
                                    .parse(_dateController.text),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _dateController.text =
                                  "${pickedDate.toLocal()}".split(' ')[0];
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 18),
                  SizedBox(
                    height: 60,
                    width: 110,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 13),
                            Container(
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.15),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          focusColor: Colors.white,
                          alignment: AlignmentDirectional.center,
                          isDense: true,
                          elevation: 2,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          value: _repeat,
                          items: const [
                            DropdownMenuItem(
                              value: 'Never',
                              child: Text('Never'),
                            ),
                            DropdownMenuItem(
                              value: 'Daily',
                              child: Text('Daily'),
                            ),
                            DropdownMenuItem(
                              value: 'Weakly',
                              child: Text('Weakly'),
                            ),
                            DropdownMenuItem(
                              value: 'Monthly',
                              child: Text('Monthly'),
                            ),
                            DropdownMenuItem(
                              value: 'Yearly',
                              child: Text('Yearly'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _repeat = value!;
                            });
                          },
                          decoration:
                              const InputDecoration(labelText: 'Repetition'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.15),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    focusColor: Colors.white,
                    alignment: AlignmentDirectional.center,
                    isDense: true,
                    elevation: 2,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    value: _category,
                    items: const [
                      DropdownMenuItem(
                        value: 'Cat 1',
                        child: Text('Cat 1'),
                      ),
                      DropdownMenuItem(
                        value: 'Cat 2',
                        child: Text('Cat 2'),
                      ),
                      DropdownMenuItem(
                        value: 'Cat 3',
                        child: Text('Cat 3'),
                      ),
                      DropdownMenuItem(
                        value: 'Cat 4',
                        child: Text('Cat 4'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _category = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Catagory'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.15),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    focusColor: Colors.white,
                    alignment: AlignmentDirectional.center,
                    isDense: true,
                    elevation: 2,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    value: _transactionType,
                    items: const [
                      DropdownMenuItem(
                        value: 'Income',
                        child: Text('Income'),
                      ),
                      DropdownMenuItem(
                        value: 'Expense',
                        child: Text('Expense'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _transactionType = value!;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Transaction Type'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Button(
                  onPressed: _submitData,
                  displayText: 'Add Transaction',
                  width: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _presentDatePicker() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null && pickedDate != _selectedDate) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   }
  // }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      _titleController.clear();
      _amountController.clear();

      setState(() {
        _dateController =
            TextEditingController(text: DateTime.now().toString());
        _transactionType = 'Income';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction added successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
