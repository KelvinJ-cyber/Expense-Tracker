import 'package:expenses_tracker/DateTime/date_time_helper.dart';
import 'package:expenses_tracker/models/expenses_items.dart';
import 'package:flutter/cupertino.dart';

class ExpenseData extends ChangeNotifier {

  // List of all expenses
   List <ExpenseItem> overallExpensesList = [];


   // get list
   List<ExpenseItem> getAllExpensesList(){
     return overallExpensesList;
   }

   // add new expense
   void addExpenses(ExpenseItem newExpense){
     overallExpensesList.add(newExpense);
     notifyListeners();

   }

   void deleteExpense(ExpenseItem delExpense){
     overallExpensesList.remove(delExpense);
     notifyListeners();
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

   Map<String, double> calculateDailyExpensesSummary(){
     Map<String, double> dailyExpensesSummary = {};

     for(var expense in overallExpensesList){
       String date = convertDateTime(expense.dataTime);
       double amount = double.parse(expense.amount) ;

       if(dailyExpensesSummary.containsKey(date)){
         double currentAmount = dailyExpensesSummary[date]!;
         currentAmount += amount;
         dailyExpensesSummary[date] = currentAmount;
       }else{
           dailyExpensesSummary.addAll({date: amount});
       }
     }
      return dailyExpensesSummary;
   }
}