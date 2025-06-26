import 'package:expenses_tracker/Data/ExpenseData.dart';
import 'package:expenses_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main(){

  // await Hive.initFlutter();
  // await Hive.openBox("expense_database");


  runApp(const ExpensesTracker());
}

class ExpensesTracker extends StatelessWidget {
  const ExpensesTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExpenseData(),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
    );

  }
}
