import 'package:expense_tracker/screens/AddExpensePage.dart';
import 'package:expense_tracker/screens/ExpenseSummaryPage.dart';
import 'package:expense_tracker/screens/ViewExpensesPage.dart';
import 'package:flutter/material.dart';

import '../services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    startNotification();
  }

  Future<void> startNotification() async {
    await scheduleDailyNotification();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Daily reminder set for 8:00 PM!')),
    );
  }

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
