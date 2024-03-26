import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/styles.dart';
import '/domain/bloc/expenses_bloc/expenses_bloc.dart';
import '/presentation/screens/homescreen/components/expense_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExpensesBloc>().add(ExpensesSearchEvent(''));
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: TextField(
          autofocus: true,
          controller: _controller,
          onChanged: (val) {
            context
                .read<ExpensesBloc>()
                .add(ExpensesSearchEvent(_controller.text));
          },
          decoration: InputDecoration(
              hintText: 'Search your expenses...',
              border: InputBorder.none,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(
                      () {
                        _controller.clear();
                        context
                            .read<ExpensesBloc>()
                            .add(ExpensesSearchEvent(_controller.text));
                      },
                    );
                  },
                  icon: const Icon(Icons.close))),
        ),
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (context.watch<ExpensesBloc>().searchExpensesList.isEmpty) {
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
                  context.watch<ExpensesBloc>().searchExpensesList.length,
              itemBuilder: (context, index) {
                final expense =
                    context.watch<ExpensesBloc>().searchExpensesList[index];
                return ExpenseTile(expense: expense);
              },
            );
          }
        },
      ),
    );
  }
}
