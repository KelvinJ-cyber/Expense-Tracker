import 'package:expenses_tracker/models/expenses_items.dart';
import 'package:flutter/material.dart';

class ExpenseData{

  // List of all expenses
   List <ExpenseItem> overallExpensesList = [];

   // get list
   List<ExpenseItem> getAllExpensesList(){
     return overallExpensesList;
   }

   // add new expense
   void addExpenses(ExpenseItem newExpense){
     overallExpensesList.add(newExpense);
   }

   void deleteExpense(ExpenseItem delExpense){
     overallExpensesList.remove(delExpense);
   }

   String getDayName(DateTime dateTime){
        switch(dateTime.weekday){
          case 1:
            return "Monday";
          case 2:
            return "Tuesday";
          case 3:
            return "Wednesday";
          case 4:
            return "Thursday";
          case 5:
            return "Friday";
          case 6:
            return "Saturday";
          case 7:
            return "Sunday";
          default:
            return "";
        }
   }

   DateTime startOfWeekDate(){
     DateTime? startOfWeekDate;

     //get today's date
     DateTime today = DateTime.now();

     // go backwards from today to find sunday
     for(int i = 0; i < 7; i++){
       if (getDayName(today.subtract(Duration(days: i))) == "Sunday"){
          startOfWeekDate = today.subtract(Duration(days: i));
       }
     }
     return startOfWeekDate!;
   }

   Map<String,double> calculateDailyExpensesSummary(){
     Map<String, double> dailyExpensesSummary = {};

   }
}