import 'package:expense_tracker/screens/AddExpensePage.dart';
import 'package:expense_tracker/screens/ExpenseSummaryPage.dart';
import 'package:expense_tracker/screens/ViewExpensesPage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Expense Tracker',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Expenses',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  'Summary',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ViewExpensesPage(),
            Expensesummarypage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExpensePage(
                        expense: null,
                        index: -1,
                      )),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
