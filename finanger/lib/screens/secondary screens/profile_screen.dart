import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/text_field_input.dart';
import '/../widgets/button.dart';
import '../login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String _userName = "John Doe";
  final String _userEmail = "john.doe@example.com";
  final List<Map<String, String>> _accounts = [
    {'name': 'Wallet', 'balance': '\$1,500'},
    {'name': 'HBL', 'balance': '\$108,500'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _userEmail,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Text(
                  'Accounts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ..._accounts.map((account) {
              return Card(
                shadowColor: Colors.green,
                child: ListTile(
                  title: Text(account['name']!),
                  subtitle: Text('Balance: ${account['balance']}'),
                ),
              );
            }),
            const SizedBox(height: 16),
            Button(
              width: 180,
              onPressed: () {
                _showUpdateDialog(_accounts);
              },
              displayText: 'Add New Account',
            ),
            // const SizedBox(height: 36),
            // Button(
            //   width: 160,
            //   onPressed: () {
            //     // Handle logout
            //   },
            //   displayText: 'Logout',
            //   icon: const Icon(Icons.logout),
            // ),
          ],
        ),
      ),
    );
  }

  void _showUpdateDialog(List<Map<String, String>> tx) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController balanceController = TextEditingController();

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
                textEditingController: nameController,
                hintText: 'Account Name',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: balanceController,
                hintText: 'Starting Balance',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              // TextFieldInput(
              //   textEditingController: dateController,
              //   hintText: 'Date',
              //   textInputType: TextInputType.datetime,
              //   onTap: () async {
              //     DateTime? pickedDate = await showDatePicker(
              //       context: context,
              //       initialDate: tx.date,
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime(2101),
              //     );
              //     if (pickedDate != null) {
              //       setState(() {
              //         dateController.text =
              //             "${pickedDate.toLocal()}".split(' ')[0];
              //       });
              //     }
              //   },
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tx.add({
                    'name': nameController.text,
                    'balance': balanceController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
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
}
