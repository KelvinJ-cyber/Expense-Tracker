import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main(){
  runApp(const ExpensesTracker());
}

class ExpensesTracker extends StatelessWidget {
  const ExpensesTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    );


  }
}
