// Bloc Implementation
import 'package:expense_tracker/bloc/expense_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final Database database;
  List<Expense> _expenses = [];

  ExpenseBloc({required this.database}) : super(ExpenseLoading()) {
    on<LoadExpenses>((event, emit) async {
      final List<Map<String, dynamic>> maps = await database.query('expenses');
      print("MAPSS : $maps");
      _expenses = List.generate(maps.length, (i) {
        return Expense(
          description: maps[i]['description'],
          amount: maps[i]['amount'],
          date: maps[i]['date'],
          id: maps[i]['id'],
        );
      });
      emit(ExpenseLoaded(_expenses));
    });

    on<AddExpense>((event, emit) async {
      await database.insert(
        'expenses',
        {
          'description': event.expense.description,
          'amount': event.expense.amount,
          'date': event.expense.date,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      _expenses.add(event.expense);
      emit(ExpenseLoaded(List.from(_expenses)));
    });

    on<DeleteExpense>((event, emit) async {
      await database.delete(
        'expenses',
        where: 'id = ?',
        whereArgs: [event.index], // Assuming index corresponds to the row ID
      );
      _expenses.removeAt(_expenses.indexOf(_expenses.firstWhere(
        (element) => element.id == event.index,
      )));
      emit(ExpenseLoaded(List.from(_expenses)));
    });

    on<EditExpense>((event, emit) async {
      await database.update(
        'expenses',
        {
          'description': event.expense.description,
          'amount': event.expense.amount,
          'date': event.expense.date,
        },
        where: 'id = ?',
        whereArgs: [event.index], // Assuming index corresponds to the row ID
      );
      _expenses.removeAt(event.index);
      _expenses.add(event.expense);
      emit(ExpenseLoaded(List.from(_expenses)));
    });
  }
}
