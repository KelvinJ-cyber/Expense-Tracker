import 'package:expenses_tracker/Data/ExpenseData.dart';
import 'package:expenses_tracker/components/expense_tile.dart';
import 'package:expenses_tracker/components/expenses_summary.dart';
import 'package:expenses_tracker/models/expenses_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  // @override
  // void initState() {
  //
  //   super.initState();
  //   Provider.of<ExpenseData>(context, listen: false).prepareData();
  // }

  void addExpense() {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                  "Add new expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Expense Name",

                    ),
                    controller: newExpenseNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Expense Amount",
                    ),
                    controller: newExpenseAmountController,
                  )
                ],
              ),
              actions: [
                MaterialButton(
                    onPressed: save,
                    child: Text("Save")
                ),
                MaterialButton(
                    onPressed: cancel,
                    child: Text("Cancel")
                ),
              ],
            ));
  }

  void deleteExpense(ExpenseItem expenseItem) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expenseItem);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Expense deleted successfully"))
    );
  }

  void save() {
    if (newExpenseNameController.text.isEmpty ||
        newExpenseAmountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill in all fields"))
      );
      return;
    }
    ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dataTime: DateTime.now()
    );
    Provider.of<ExpenseData>(context, listen: false).addExpenses(newExpense);
    Navigator.pop(context);
    clearTextFields();
  }

  void cancel() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    Navigator.pop(context);
  }

  void clearTextFields() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) =>
          Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: addExpense,
              backgroundColor: Colors.teal[400],
              child: Icon(Icons.add_outlined),
            ),
            body: ListView(children: [
              // Weekly Expenses Summary
              ExpensesSummary(startOfWeek: value.startOfWeekDate()),

              const SizedBox(height: 20),

              // Expenses Summary
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value
                    .getAllExpensesList()
                    .length,
                itemBuilder: (context, index) =>
                    ExpenseTile(
                      name: value.getAllExpensesList()[index].name,
                      amount: value.getAllExpensesList()[index].amount,
                      dateTime: value.getAllExpensesList()[index].dataTime,
                      deleteTapped: (p0) =>
                          deleteExpense(value.getAllExpensesList()[index]),
                    ),
              ),
            ],
            ),
          ),
    );
  }
}