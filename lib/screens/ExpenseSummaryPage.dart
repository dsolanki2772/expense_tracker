import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/expense_bloc.dart';
import '../bloc/expense_state.dart';

class Expensesummarypage extends StatelessWidget {
  const Expensesummarypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Summary'),
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            final expenses = state.expenses;

            final Map<String, double> weeklySummary = {};
            final Map<String, double> monthlySummary = {};

            for (var expense in expenses) {
             // final date = DateTime.parse(expense.date);
              DateFormat inputFormat = DateFormat("dd-MM-yyyy");
              DateTime dateTime = inputFormat.parse(expense.date);
              DateFormat outputFormat = DateFormat("MM-yyyy");
              String month = outputFormat.format(dateTime);

              DateFormat inputFormat1 = DateFormat("dd-MM-yyyy");
              DateTime dateTime1 = inputFormat1.parse(expense.date);
              DateFormat outputFormat1 = DateFormat("ww-yyyy");
              String week = outputFormat1.format(dateTime1);
              //final week = DateFormat('yyyy-ww').format(date);
             // final month = DateFormat('yyyy-MM').format(date);

              weeklySummary[week] = (weeklySummary[week] ?? 0) + expense.amount;
              monthlySummary[month] =
                  (monthlySummary[month] ?? 0) + expense.amount;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Weekly Summary',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...weeklySummary.entries.map((entry) => ListTile(
                          title: Text('Week ${entry.key.split('-')[1]}'),
                          subtitle: Text('Year ${entry.key.split('-')[0]}'),
                          trailing: Text('₹${entry.value.toStringAsFixed(2)}'),
                        )),
                    const SizedBox(height: 20),
                    const Text('Monthly Summary',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...monthlySummary.entries.map((entry) => ListTile(
                          title: Text('Month ${entry.key.split('-')[1]}'),
                          subtitle: Text('Year ${entry.key.split('-')[0]}'),
                          trailing: Text('₹${entry.value.toStringAsFixed(2)}'),
                        )),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child:
                  Text('Something went wrong.', style: TextStyle(fontSize: 16)),
            );
          }
        },
      ),
    );
  }
}
