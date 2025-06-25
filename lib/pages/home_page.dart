import 'package:expenses_tracker/Data/ExpenseData.dart';
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

  void addExpense(){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
                style:GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                "Add new expense" ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newExpenseNameController,
                ),
                TextField(
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

  void save(){
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
        amount: double.tryParse(newExpenseAmountController.text) ?? 0.0,
      dataTime: DateTime.now()
    );
     Provider.of<ExpenseData>(context, listen: false).addExpenses(newExpense);
  }

  void cancel(){}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: addExpense,
        backgroundColor:Colors.teal[400],
        child: Icon(Icons.add),
      ),
    );
  }
}
