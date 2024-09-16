import 'package:flutter/material.dart';

import '../secondary screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showNotifications = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (_showNotifications) {
                  setState(() {
                    _showNotifications = false;
                  });
                }
              },
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.greenAccent,
                        Colors.greenAccent.shade700,
                      ]),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen())),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white38,
                                  // backgroundImage:
                                  //     NetworkImage('https://via.placeholder.com/150'),
                                ),
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hello "User"!',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Text('Welcome back',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(
                                            255, 122, 122, 122))),
                              ],
                            ),
                            const Expanded(
                                child: SizedBox(
                              width: 10,
                            )),
                            IconButton(
                              onPressed: _toggleNotifications,
                              icon: const Icon(Icons.notifications),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'YOUR BALANCE',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                '\$41,379.00',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 4,
                                              color:
                                                  Colors.greenAccent.shade700,
                                              offset: const Offset(1, 2))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Color(0xff36dd82),
                                            child: Icon(Icons.arrow_upward,
                                                color: Colors.white, size: 20),
                                          ),
                                          SizedBox(width: 7),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Income',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                '\$3500.00',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 4,
                                              color: Colors.redAccent.shade700,
                                              offset: const Offset(0.5, 2))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                Color.fromARGB(134, 233, 4, 4),
                                            child: Icon(Icons.arrow_downward,
                                                color: Colors.white, size: 20),
                                          ),
                                          SizedBox(width: 7),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Expense',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                '\$859.00',
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        TabBar(
                          controller: _tabController,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(
                              child: Text('Recent Transactions',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Tab(
                              child: Text('Upcoming Expenses',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildRecentTransactions(),
                              _buildUpcomingBills(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_showNotifications)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.fromLTRB(0, 50, 16, 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ListView(
                      children: const [
                        Text('You have an income of \$3000 from Stripe.'),
                        SizedBox(height: 10),
                        Text('You have an expenditure of \$15 on Youtube.'),
                        SizedBox(height: 10),
                        Text(
                            'You have an expenditure of \$139 on Google Play.'),
                        SizedBox(height: 10),
                        Text('You have an expenditure of \$180 on OVO.'),
                        SizedBox(height: 10),
                        Text('You have an expenditure of \$180 on COD Mobile.'),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    List<Map<String, dynamic>> transactions = [
      {
        'title': 'Stripe',
        'subtitle': 'Monthly Salary',
        'amount': '+\$3,000',
        'date': '1 May 2024',
        'icon': Icons.attach_money
      },
      {
        'title': 'Youtube',
        'subtitle': 'Subscription Payment',
        'amount': '-\$15.00',
        'date': '16 May 2024',
        'icon': Icons.play_circle_fill
      },
      {
        'title': 'Google Play',
        'subtitle': 'E-book Purchase',
        'amount': '-\$139.00',
        'date': '14 May 2024',
        'icon': Icons.shop
      },
      {
        'title': 'OVO',
        'subtitle': 'Top Up E-Money',
        'amount': '-\$180.00',
        'date': '18 May 2024',
        'icon': Icons.account_balance_wallet
      },
      {
        'title': 'COD Mobile',
        'subtitle': 'In-Game Transaction',
        'amount': '-\$180.00',
        'date': '18 May 2024',
        'icon': Icons.games
      },
    ];

    return ListView(
      children: transactions.map((transaction) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 238, 238, 238),
            child: Icon(
              transaction['icon'],
              color: const Color.fromARGB(255, 106, 196, 111),
            ),
          ),
          title: Text(transaction['title']),
          subtitle: Text(transaction['subtitle']),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(transaction['amount'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(transaction['date'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingBills() {
    List<Map<String, dynamic>> bills = [
      {
        'title': 'Rent',
        'subtitle': 'Due Date: 1 Aug 2024',
        'amount': '\$1000.00',
        'icon': Icons.home
      },
      {
        'title': 'Internet Bill',
        'subtitle': 'Due Date: 5 Aug 2024',
        'amount': '\$40.00',
        'icon': Icons.wifi
      },
      {
        'title': 'Electricity Bill',
        'subtitle': 'Due Date: 10 Aug 2024',
        'amount': '\$75.00',
        'icon': Icons.flash_on
      },
    ];

    return ListView(
      children: bills.map((bill) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(
              bill['icon'],
              color: const Color.fromARGB(255, 106, 196, 111),
            ),
          ),
          title: Text(bill['title']),
          subtitle: Text(bill['subtitle']),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(bill['amount'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
