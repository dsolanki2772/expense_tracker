// Bloc Events
import '../models/expense.dart';

// Bloc Events
abstract class ExpenseEvent {}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;

  AddExpense(this.expense);
}

class DeleteExpense extends ExpenseEvent {
  final int index;

  DeleteExpense(this.index);
}

class EditExpense extends ExpenseEvent {
  final Expense expense;
  final int index;

  EditExpense(this.expense, this.index);
}
