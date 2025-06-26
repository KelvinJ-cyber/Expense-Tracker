import 'package:expenses_tracker/BarGraph/barGraph.dart';
import 'package:expenses_tracker/Data/ExpenseData.dart';
import 'package:expenses_tracker/DateTime/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class ExpensesSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpensesSummary({
    super.key,
    required this.startOfWeek
  });
   double calculateMax(
       ExpenseData value,
       String sunday,
       String monday,
       String tuesday,
       String wednesday,
       String thursday,
       String friday,
       String saturday
       ){

      double? max = 100;

      List<double> values = [
        value.calculateDailyExpensesSummary()[sunday] ?? 0,
        value.calculateDailyExpensesSummary()[monday] ?? 0,
        value.calculateDailyExpensesSummary()[tuesday] ?? 0,
        value.calculateDailyExpensesSummary()[wednesday] ?? 0,
        value.calculateDailyExpensesSummary()[thursday] ?? 0,
        value.calculateDailyExpensesSummary()[friday] ?? 0,
        value.calculateDailyExpensesSummary()[saturday] ?? 0,
      ];
   values.sort();
      max = values.last = 1.1;
      return max == 0 ? 100 : max;
}

String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday)
{
  List<double> values = [
    value.calculateDailyExpensesSummary()[sunday] ?? 0,
    value.calculateDailyExpensesSummary()[monday] ?? 0,
    value.calculateDailyExpensesSummary()[tuesday] ?? 0,
    value.calculateDailyExpensesSummary()[wednesday] ?? 0,
    value.calculateDailyExpensesSummary()[thursday] ?? 0,
    value.calculateDailyExpensesSummary()[friday] ?? 0,
    value.calculateDailyExpensesSummary()[saturday] ?? 0,
  ];
  double total = 0;
  for (int i =0; i < values.length; i++){
    total += values[i];
  }
  return total.toStringAsFixed(2);
}
  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTime(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTime(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTime(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTime(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTime(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTime(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTime(startOfWeek.add(const Duration(days: 6)));




    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
          children: [
            Row(
              children: [
                Text("Expenses Summary for the week ",style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}')
              ],
            ),
            SizedBox(
              height: 200,

              child: MyBarGraph(
                  maxY: 100,
                  sunAmount: value.calculateDailyExpensesSummary()[sunday] ?? 0,
                  monAmount: value.calculateDailyExpensesSummary()[monday] ?? 0,
                  tueAmount: value.calculateDailyExpensesSummary()[tuesday] ?? 0,
                  wedAmount: value.calculateDailyExpensesSummary()[wednesday] ?? 0,
                  thuAmount: value.calculateDailyExpensesSummary()[thursday] ?? 0,
                  friAmount: value.calculateDailyExpensesSummary()[friday] ?? 0,
                  satAmount: value.calculateDailyExpensesSummary()[saturday] ?? 0,
              ),
            ),
          ],
        )
    );
  }
}
