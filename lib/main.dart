import 'package:expenses_tracker/Data/ExpenseData.dart';
import 'package:expenses_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const ExpensesTracker());
}

class ExpensesTracker extends StatelessWidget {
  const ExpensesTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
       create: (context) => ExpenseData(),
       builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
         home: HomePage(),
    )
    );


  }
}
