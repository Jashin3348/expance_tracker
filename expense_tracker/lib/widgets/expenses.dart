import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: "flutter",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "cinema",
        amount: 15,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (cxt) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense added currently"),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker"), actions: [
        IconButton(
            onPressed: openAddExpenseOverlay, icon: const Icon(Icons.add))
      ]),
      body:
          Column(children: [Chart(expenses: _registeredExpense), Expanded(child: mainContent)]),
    );
  }
}
