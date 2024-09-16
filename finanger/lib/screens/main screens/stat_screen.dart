import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '/../utils/constants.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Color _tabTitleColor = Colors.green;
  Color _scaffoldBackgroundColor = scaffoldBackgroundColor;

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Stripe',
      'subtitle': 'Monthly Salary',
      'amount': '+\$3,000',
      'date': '1 May 2024',
      'icon': Icons.attach_money
    },
    {
      'title': 'OctaFX',
      'subtitle': 'Investment Returns',
      'amount': '+\$500',
      'date': '10 May 2024',
      'icon': Icons.attach_money
    },
    {
      'title': 'OctaFX_Out',
      'subtitle': 'Investment Returns',
      'amount': '-\$300',
      'date': '10 May 2024',
      'icon': Icons.attach_money
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
    {
      'title': 'Youtube_2',
      'subtitle': 'Subscription Payment',
      'amount': '-\$15.00',
      'date': '16 May 2024',
      'icon': Icons.play_circle_fill
    },
    {
      'title': 'Youtube_3',
      'subtitle': 'Subscription Payment',
      'amount': '-\$15.00',
      'date': '16 May 2024',
      'icon': Icons.play_circle_fill
    },
    {
      'title': 'Youtube_4',
      'subtitle': 'Subscription Payment',
      'amount': '-\$15.00',
      'date': '16 May 2024',
      'icon': Icons.play_circle_fill
    },
    {
      'title': 'Youtube',
      'subtitle': 'Subscription Payment',
      'amount': '-\$15.00',
      'date': '16 May 2024',
      'icon': Icons.play_circle_fill
    },
  ];

  final Map<String, double> budgets = {
    'OctaFX_Out': 300,
    'GooglePlay': 300,
    'OVO': 400,
    'COD Mobile': 180,
    'Youtube_2': 100,
    'Youtube_3': 60,
    'Youtube_4': 80,
    'Youtube': 75
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // TabController to update colors when tab changes
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          _tabTitleColor = Colors.green;
          _scaffoldBackgroundColor = scaffoldBackgroundColor;
        } else {
          _tabTitleColor = Colors.red;
          _scaffoldBackgroundColor = const Color.fromARGB(255, 250, 244, 245);
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Map<String, double> createFilteredDataMap(
      List<Map<String, dynamic>> transactions, String type) {
    final Map<String, double> dataMap = {};

    for (var transaction in transactions) {
      final title = transaction['title'] as String?;
      final amountStr = transaction['amount'] as String?;

      if (title != null && amountStr != null) {
        final double amount =
            double.tryParse(amountStr.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;

        if ((type == 'income' && amountStr.contains('+')) ||
            (type == 'expenses' && amountStr.contains('-'))) {
          dataMap[title] = amount;
        }
      }
    }
    return dataMap;
  }

  double calculateTotalSum(
      List<Map<String, dynamic>> transactions, String type) {
    double totalSum = 0.0;

    for (var transaction in transactions) {
      final amountStr = transaction['amount'] as String?;

      if (amountStr != null) {
        final double amount =
            double.tryParse(amountStr.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;

        if ((type == 'income' && amountStr.contains('+')) ||
            (type == 'expenses' && amountStr.contains('-'))) {
          totalSum += amount;
        }
      }
    }
    return totalSum;
  }

  /// Helper function to format legend labels with percentage
  Map<String, String> formatLegendLabels(
      Map<String, double> dataMap, double totalSum) {
    return dataMap.map((title, value) {
      final percentage = ((value / totalSum) * 100).toStringAsFixed(1);
      return MapEntry(title, '$title ($percentage%)');
    });
  }

  Widget _buildPieChart(String type) {
    final dataMap = createFilteredDataMap(transactions, type);
    final totalSum = calculateTotalSum(transactions, type);
    final legendLabels = formatLegendLabels(dataMap, totalSum);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      height: 260,
      child: Center(
        child: PieChart(
          chartRadius: 200,
          chartType: ChartType.ring,
          dataMap: dataMap,
          legendLabels: legendLabels,
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            showLegends: true,
          ),
          initialAngleInDegree: -90,
          chartValuesOptions: const ChartValuesOptions(showChartValues: false),
          centerWidget: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total $type',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                Text(
                  '\$${totalSum.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList(List<Map<String, dynamic>> transactions,
      {Map<String, double>? budgets, double? totalSum}) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          final title = transaction['title'];
          double sum = 1;
          if (budgets != null && budgets.containsKey(title)) {
            sum = budgets[title] as double;
          } else if (totalSum != null) {
            sum = totalSum;
          }

          // Parse the amount
          final amountStr = transaction['amount'] as String;
          final double amount =
              double.tryParse(amountStr.replaceAll(RegExp(r'[^\d.]'), '')) ??
                  0.0;
          final progress = amount / sum;

          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            leading: Icon(
              transaction['icon'],
              color: transaction['amount'].contains('+')
                  ? Colors.green
                  : Colors.red,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(transaction['title']),
                    Text(
                      transaction['amount'].contains('+')
                          ? transaction['amount']
                          : '${transaction['amount']} / \$${sum.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transaction['amount'].contains('+')
                            ? Colors.green
                            : Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: _tabController.index == 0
                      ? Colors.grey[200]
                      : Colors.grey[350],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    transaction['amount'].contains('+')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final incomeTransactions =
        transactions.where((tx) => tx['amount'].contains('+')).toList();
    final expenseTransactions =
        transactions.where((tx) => tx['amount'].contains('-')).toList();

    final incomeTotalSum = calculateTotalSum(transactions, 'income');

    return SafeArea(
      child: Scaffold(
        backgroundColor: _scaffoldBackgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                controller: _tabController,
                labelColor: _tabTitleColor,
                indicatorColor: _tabTitleColor,
                tabs: const [
                  Tab(text: 'Income'),
                  Tab(text: 'Expenses'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPieChart('income'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(27, 5, 0, 12),
                        child: Text('Income Breakdown',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      _buildTransactionList(incomeTransactions,
                          totalSum: incomeTotalSum),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPieChart('expenses'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(27, 5, 0, 12),
                        child: Text('Expense Breakdown',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      _buildTransactionList(expenseTransactions,
                          budgets: budgets),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
