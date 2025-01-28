import 'package:expense_tracker/bloc/expense_bloc.dart';
import 'package:expense_tracker/screens/AddExpensePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';

class ViewExpensesPage extends StatefulWidget {
  const ViewExpensesPage({super.key});

  @override
  State<ViewExpensesPage> createState() => _ViewExpensesPageState();
}

class _ViewExpensesPageState extends State<ViewExpensesPage> {
  String _sortOrder = 'asc';
  DateTime? _filterDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _sortOrder,
                  items: const [
                    DropdownMenuItem(
                        value: 'asc', child: Text('Ascending')),
                    DropdownMenuItem(
                        value: 'desc', child: Text('Descending')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _sortOrder = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        _filterDate = picked;
                      });
                    }
                  },
                  child: const Text('Filter by Date'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _filterDate = null;
                    });
                  },
                  child: const Text('Clear Filter'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoading) {
                  context.read<ExpenseBloc>().add(LoadExpenses());
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ExpenseLoaded) {
                  var expenses = state.expenses;
                  if (_filterDate != null) {
                    expenses = expenses
                        .where((expense) =>
                            expense.date ==
                            DateFormat('dd-MM-yyyy').format(_filterDate!))
                        .toList();
                  }

                  if (_sortOrder == 'asc') {
                    expenses.sort((a, b) => a.date.compareTo(b.date));
                  } else {
                    expenses.sort((a, b) => b.date.compareTo(a.date));
                  }
                  return expenses.isEmpty
                      ? const Center(
                          child: Text('No expenses recorded yet.',
                              style: TextStyle(fontSize: 16)),
                        )
                      : ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: ListTile(
                                  title: Text(expense.description),
                                  subtitle: Text(
                                    '${expense.amount.toStringAsFixed(2)} - ${expense.date}',
                                  ),
                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit_outlined),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddExpensePage(
                                                    expense: expense,
                                                    index: index,
                                                  ),
                                                ));
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            context
                                                .read<ExpenseBloc>()
                                                .add(DeleteExpense(expense.id));
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        );
                } else {
                  return const Center(
                    child: Text('Something went wrong.',
                        style: TextStyle(fontSize: 16)),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
