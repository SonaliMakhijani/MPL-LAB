import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/styles.dart';
import '/data/repositories/common_interfaces/expenses_repo_interface.dart';
import '/domain/bloc/expenses_bloc/expenses_bloc.dart';
import '/presentation/widgets/loader.dart';
import '../homescreen/components/expense_tile.dart';

class ViewExpenses extends StatefulWidget {
  const ViewExpenses({super.key, this.category});
  final ExpenseCategory? category;

  @override
  State<ViewExpenses> createState() => _ViewExpensesState();
}

class _ViewExpensesState extends State<ViewExpenses> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<ExpensesBloc>()
        .add(ExpensesLoadCategoryEvent(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category?.name ?? 'All Expenses'),
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (state is ExpensesLoadingState) {
            return const Loader();
          } else if (context
              .watch<ExpensesBloc>()
              .listOfCategoryExpenses
              .isEmpty) {
            return const Center(
              child: Text(
                'No Results Found',
                style: TextStyle(fontSize: 22),
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(paddingDefault),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  context.watch<ExpensesBloc>().listOfCategoryExpenses.length,
              itemBuilder: (context, index) {
                final expense =
                    context.watch<ExpensesBloc>().listOfCategoryExpenses[index];
                return ExpenseTile(expense: expense);
              },
            );
          }
        },
      ),
    );
  }
}
