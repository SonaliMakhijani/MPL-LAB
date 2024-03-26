import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/styles.dart';
import '/domain/bloc/expenses_bloc/expenses_bloc.dart';
import '../add_or_edit_expense/add_or_edit_expense.dart';
import '/presentation/screens/search/search_page.dart';
import '/data/repositories/common_interfaces/expenses_repo_interface.dart';
import '/presentation/screens/homescreen/components/expense_tile.dart';
import '/presentation/screens/homescreen/components/category_tile.dart';
import '/presentation/screens/homescreen/components/app_drawer.dart';
import '/presentation/widgets/error_widget.dart';
import '/presentation/widgets/loader.dart';
import '../view_expenses/view_expenses_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    context.read<ExpensesBloc>().add(ExpensesLoadEvent());
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text(
          'expensio',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            icon: const Icon(Icons.search_rounded),
          )
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddOrEditExpensePage(),
              fullscreenDialog: true,
              barrierDismissible: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (state is ExpensesLoadingState) {
            return const Loader();
          } else if (state is ExpensesErrorState) {
            return CustomErrorWidget(
              exceptionCaught: state.exception,
              onPressed: () {
                context.read<ExpensesBloc>().add(ExpensesLoadEvent());
              },
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(paddingDefault),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.all(paddingDefault),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.4),
                    borderRadius: borderRadiusDefault,
                  ),
                  child: Column(
                    children: [
                      const Text('Total Monthly Expenses'),
                      Text(
                        "₹${context.read<ExpensesBloc>().allExpensesSum.toString()}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 500, maxWidth: 300),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 2.4,
                    children: List.generate(
                      ExpenseCategory.values.length,
                      (index) => ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 150, maxWidth: 300),
                        child: CategoryTile(index),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Expenses",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewExpenses(),
                          ),
                        );
                      },
                      child: const Text('more'),
                    )
                  ],
                ),
                BlocBuilder<ExpensesBloc, ExpensesState>(
                    builder: (context, state) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        context.watch<ExpensesBloc>().listOfExpenses.length,
                    itemBuilder: (context, index) {
                      final expense =
                          context.watch<ExpensesBloc>().listOfExpenses[index];
                      return ExpenseTile(expense: expense);
                    },
                  );
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
