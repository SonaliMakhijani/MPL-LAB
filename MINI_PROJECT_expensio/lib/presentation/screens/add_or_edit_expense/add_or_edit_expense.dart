import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '/core/utils/input_validation.dart';
import '/core/constants/styles.dart';
import '/core/utils/get_location.dart';
import '/core/utils/colored_log.dart';
import '/data/models/expenses_model.dart';
import '/domain/bloc/expenses_bloc/expenses_bloc.dart';
import '/domain/exceptions/app_exception.dart';
import '/data/repositories/common_interfaces/expenses_repo_interface.dart';
import 'components/category_chip.dart';

///### Screen for adding or editting an expense
/// - If no parameter is passed to the constructor, it will be in add mode
/// - If an expense is passed to the constructor and editMode==true then only it will be in edit mode
class AddOrEditExpensePage extends StatefulWidget {
  const AddOrEditExpensePage({super.key, this.editMode = false, this.expense});
  final Expenses? expense;
  final bool editMode;

  @override
  State<AddOrEditExpensePage> createState() => _AddOrEditExpensePageState();
}

class _AddOrEditExpensePageState extends State<AddOrEditExpensePage> {
  @override
  void initState() {
    super.initState();
    // if edit mode is true then initialize the text controllers with the expense values
    widget.editMode ? _initEditMode() : _getPosition();
  }

  ExpenseCategory selectedCategory = ExpenseCategory.others;
  Expenses editExpense = Expenses();
  String? locationName;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountSpentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editMode ? 'Update Expense' : 'Add an Expense'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _key,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(paddingDefault),
                children: [
                  TextFormField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    validator: InputValidator.expensesTitle,
                    decoration: const InputDecoration(
                      label: Text('Spent on'),
                      hintText: 'Enter the expenditure item name',
                    ),
                  ),
                  TextFormField(
                    controller: _amountSpentController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^\d*\.?\d{0,4})')),
                    ],
                    validator: InputValidator.amountSpent,
                    decoration: const InputDecoration(
                      label: Text('Amount spent'),
                      hintText: 'Enter the amount of money spent',
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    // validator: InputValidator.name,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      hintText: 'Describe the expense',
                    ),
                  ),
                  TextFormField(
                    controller: _platformController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Platform name'),
                      hintText: 'Enter the expenditure platform name',
                    ),
                  ),
                  const SizedBox(height: paddingDefault / 2),
                  Wrap(
                    children: [
                      ...List.generate(
                        ExpenseCategory.values.length,
                        (index) => CategoryChip(
                          category: ExpenseCategory.values[index],
                          selectedCategory: selectedCategory,
                          onTap: () {
                            setState(() {
                              selectedCategory = ExpenseCategory.values[index];
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(paddingDefault),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.maxFinite),
              child: ElevatedButton(
                onPressed: widget.editMode ? _updateExpense : _addExpense,
                child: Text(widget.editMode ? 'Update Expense' : 'Add Expense'),
              ),
            ),
          )
        ],
      ),
    );
  }

  _addExpense() async {
    try {
      if (_key.currentState?.validate() ?? false) {
        Expenses expense = Expenses()
          ..title = _titleController.text.trim()
          ..amountSpent = double.tryParse(_amountSpentController.text.trim())
          ..description = _descriptionController.text.trim()
          ..platformName = _platformController.text.trim()
          ..location = locationName ?? ''
          ..category = selectedCategory.name
          ..createdOn = DateTime.now()
          ..id = const Uuid().v4();

        context.read<ExpensesBloc>().add(ExpensesAddEvent(expense));
        ColoredLog.yellow(expense, name: 'Expense');
        Navigator.pop(context);
      }
    } catch (e) {
      ColoredLog.red(e, name: 'Add expenses Error');
    }
  }

  _getPosition() async {
    try {
      final position = await determinePosition();
      locationName =
          await reverseGeocode(position.latitude, position.longitude);
      ColoredLog(position, name: 'Position');
      ColoredLog(locationName, name: 'Location Name');
    } on AppException catch (e) {
      e.print;
    }
  }

  _initEditMode() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _titleController.text = widget.expense!.title!;
      _amountSpentController.text = widget.expense!.amountSpent.toString();
      _descriptionController.text = widget.expense!.description!;
      _platformController.text = widget.expense!.platformName!;
      selectedCategory = ExpenseCategory.values
          .firstWhere((element) => element.name == widget.expense!.category);
    });
  }

  _updateExpense() async {
    try {
      if (_key.currentState?.validate() ?? false) {
        if (widget.expense != null) {
          editExpense = widget.expense!;
          editExpense
            ..title = _titleController.text.trim()
            ..amountSpent = double.tryParse(_amountSpentController.text.trim())
            ..description = _descriptionController.text.trim()
            ..platformName = _platformController.text.trim()
            ..category = selectedCategory.name;

          context.read<ExpensesBloc>().add(
                ExpensesUpdateEvent(
                  newExpense: editExpense,
                  oldExpense: widget.expense!,
                ),
              );
        }
        ColoredLog.yellow(editExpense, name: 'Updated Expense');
        Navigator.pop(context);
      }
    } catch (e) {
      ColoredLog.red(e, name: 'Update expenses Error');
    }
  }
}
