class Transactions {
  final String tId;
  final String title;
  final String type;
  final String description;
  final String category;
  final double amount;
  final DateTime date;
  final String userId;

  Transactions({
    required this.tId,
    required this.title,
    required this.type,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
    required this.userId,
  });
}
