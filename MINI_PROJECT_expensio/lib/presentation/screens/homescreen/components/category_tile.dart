import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/styles.dart';
import '/domain/bloc/expenses_bloc/expenses_bloc.dart';
import '/data/repositories/common_interfaces/expenses_repo_interface.dart';
import '/presentation/screens/view_expenses/view_expenses_list.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
    this.index, {
    super.key,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final moneySpentOnThisCategory =
        context.read<ExpensesBloc>().categorySum(ExpenseCategory.values[index]);
    final moneySpentOnAll = context.read<ExpensesBloc>().allExpensesSum;
    final category = ExpenseCategory.values[index];
    return InkWell(
      borderRadius: borderRadiusDefault,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewExpenses(category: category),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(paddingDefault / 2),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //       offset: Offset(2, 3), blurRadius: 5, color: Colors.black12)
          // ],
          color: colorScheme.surfaceVariant.withOpacity(0.4),
          borderRadius: borderRadiusDefault,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: _color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    'assets/images/${category.name}.png',
                    height: 22,
                    width: 22,
                    color: _color,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  ExpenseCategory.values[index].name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const SizedBox(height: paddingDefault / 2),
            LinearProgressIndicator(
              borderRadius: borderRadiusDefault,
              backgroundColor: _color.withOpacity(0.4),
              color: _color,
              value: (moneySpentOnThisCategory / moneySpentOnAll).isNaN
                  ? 0.01
                  : moneySpentOnThisCategory / moneySpentOnAll,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '₹${moneySpentOnThisCategory.toString().split('.').first}'),
                Text(
                  '${context.watch<ExpensesBloc>().itemsLength(ExpenseCategory.values[index])}/${context.watch<ExpensesBloc>().itemsLength(null)}',
                  style: TextStyle(
                      color: colorScheme.onBackground.withOpacity(0.3)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color get _color {
    final colorList = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.pinkAccent,
      Colors.blueGrey,
      Colors.brown
    ];
    return colorList[index];
  }
}
