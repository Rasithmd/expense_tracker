// ignore_for_file: must_be_immutable
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseChart extends StatefulWidget {
  ExpenseChart({required this.expenseList, required this.category, super.key});
  List<ExpenseModel> expenseList;
  List category;

  @override
  State<ExpenseChart> createState() => PieChart2State();
}

class PieChart2State extends State<ExpenseChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 5,
              centerSpaceColor: Colors.white,
              centerSpaceRadius: MediaQuery.of(context).size.width / 4,
              sections: showingSections(widget.expenseList, widget.category),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height / 6,
          right: MediaQuery.of(context).size.width / 3.5,
          child: const Text(
            "Expense Overview",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      List<ExpenseModel> expenseList, List category) {
    return List.generate(category.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 50.0 : 45.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: category[i]['color'],
        value: expenseList
            .where((element) => element.category == category[i]['name'])
            .length
            .toDouble(),
        title:
            '${expenseList.where((element) => element.category == category[i]['name']).length}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    });
  }
}
