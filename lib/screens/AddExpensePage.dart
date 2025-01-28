import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../models/expense.dart';

class AddExpensePage extends StatelessWidget {
  Expense? expense;
  int index;

  AddExpensePage({super.key, required this.expense, required this.index});

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();
    if (index != -1) {
      descriptionController.text = expense?.description ?? "";
      amountController.text = expense?.amount.toString() ?? "";
      dateController.text = expense?.date ?? "";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expense',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Date',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  dateController.text = DateFormat('dd-MM-yyyy').format(picked);
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                final description = descriptionController.text;
                final amount = double.tryParse(amountController.text) ?? 0.0;
                final date = dateController.text;

                if (description.isNotEmpty && amount > 0 && date.isNotEmpty) {
                  final expense = Expense(
                    description: description,
                    amount: amount,
                    date: date,
                  );
                  if (index != -1) {
                    context
                        .read<ExpenseBloc>()
                        .add(EditExpense(expense, expense.id));
                  } else {
                    context.read<ExpenseBloc>().add(AddExpense(expense));
                  }
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please fill all fields correctly.')),
                  );
                }
              },
              label: Text(
                index != -1 ? 'Update Expense' : 'Add Expense',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
