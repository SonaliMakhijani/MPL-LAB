import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/constants/styles.dart';
import '/data/repositories/common_interfaces/expenses_repo_interface.dart';
import '/data/models/expenses_model.dart';

class ViewExpensePage extends StatelessWidget {
  const ViewExpensePage({super.key, required this.expense});
  final Expenses expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expense.title ?? 'N/A'),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(paddingDefault),
        children: [
          const SizedBox(height: paddingDefault),
          Container(
            padding: const EdgeInsets.all(paddingDefault),
            decoration: BoxDecoration(
              color: _getColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/${expense.category}.png',
              height: 60,
              width: 60,
              color: _getColor,
            ),
          ),
          const SizedBox(height: 10),
          Center(child: Text(expense.category.toString().toUpperCase())),
          const SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Amount Spent',
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              Text(
                '₹${expense.amountSpent ?? 'N/A'}',
                style:
                    const TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              _infoTile("Spent On", expense.title),
              _infoTile("Description", expense.description),
              _infoTile('Platform', expense.platformName),
              _infoTile('Location', expense.location),
              _infoTile(
                'Created On',
                '${DateFormat('d/MMM').format(expense.createdOn ?? DateTime.now())}, ${DateFormat('hh:mm:aa').format((expense.createdOn ?? DateTime.now())).toString()}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  _infoTile(String title, String? info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          info == '' || info == null ? 'N/A' : info,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color get _getColor {
    final colorList = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.pinkAccent,
      Colors.blueGrey,
      Colors.brown
    ];
    Color color = Colors.red;
    for (int i = 0; i < ExpenseCategory.values.length; i++) {
      if (expense.category == ExpenseCategory.values[i].name) {
        color = colorList[i];
      }
    }
    return color;
  }
}
