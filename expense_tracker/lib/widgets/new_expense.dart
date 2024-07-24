import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || 
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (cxt) => AlertDialog(
          title: const Text("Invalid input"),
          content:
              const Text("please make sure all necessary fields are filled"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(cxt);
                },
                child: const Text("Okay"))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text("amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? "selected date"
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text("save expense"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancle"))
            ],
          )
        ],
      ),
    );
  }
}
