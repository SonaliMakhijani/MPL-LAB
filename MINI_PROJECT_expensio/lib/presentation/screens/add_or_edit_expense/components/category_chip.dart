import 'package:flutter/material.dart';

import '/data/repositories/common_interfaces/expenses_repo_interface.dart';
import '/core/constants/styles.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip(
      {super.key,
      required this.category,
      required this.selectedCategory,
      this.onTap});
  final ExpenseCategory category;
  final ExpenseCategory selectedCategory;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isSelected = category == selectedCategory;
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadiusDefault,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer
                : colorScheme.background,
            borderRadius: borderRadiusDefault,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: Colors.grey.withOpacity(0.2),
              )
            ]),
        margin: const EdgeInsets.all(
          paddingDefault / 4,
        ),
        padding: const EdgeInsets.all(paddingDefault / 2),
        child: Text(
          category.name.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: colorScheme.onPrimaryContainer),
        ),
      ),
    );
  }
}
