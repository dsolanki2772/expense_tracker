// Expense Model
class Expense {
  final String description;
  final double amount;
  final String date;
  int id;

  Expense({
    required this.description,
    required this.amount,
    required this.date,
    this.id = 0, // Default value for id
  });
}
