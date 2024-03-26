import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/exceptions/app_exception.dart';
import '/data/models/expenses_model.dart';
import '/core/utils/colored_log.dart' show ColoredLog;
import '/data/repositories/app_repository.dart';
import '/data/repositories/common_interfaces/expenses_repo_interface.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  List<Expenses> listOfExpenses = [];
  List<Expenses> listOfCategoryExpenses = [];
  List<Expenses> searchExpensesList = [];

  double get allExpensesSum {
    double val = 0;
    for (var element in listOfExpenses) {
      double elementVal = element.amountSpent ?? 0.0;
      val = val + elementVal;
    }
    return val;
  }

  double categorySum(ExpenseCategory category) {
    double val = 0;
    List<Expenses> categoryList = listOfExpenses
        .where((element) => element.category == category.name)
        .toList();
    for (var element in categoryList) {
      double elementVal = element.amountSpent ?? 0.0;
      val = val + elementVal;
    }
    return val;
  }

  int itemsLength(ExpenseCategory? category) {
    if (category == null) {
      return listOfExpenses.length;
    } else {
      List<Expenses> categoryList = listOfExpenses
          .where((element) => element.category == category.name)
          .toList();
      return categoryList.length;
    }
  }

  ExpensesBloc() : super(ExpensesInitialState()) {
    on<ExpensesLoadEvent>(_loadExpensesEvent);
    on<ExpensesAddEvent>(_addExpenseEvent);
    on<ExpensesDeleteEvent>(_deleteExpenseEvent);
    on<ExpensesUpdateEvent>(_updateExpenseEvent);
    on<ExpensesLoadCategoryEvent>(_loadExpensesCategory);
    on<ExpensesSearchEvent>(_searchExpensesEvent);
  }

  FutureOr<void> _loadExpensesEvent(
      ExpensesLoadEvent event, Emitter<ExpensesState> emit) async {
    final ExpensesRepository repo = AppRepository().expensesRepository;
    ColoredLog.cyan('loadExpensesEvent initiated', name: "Event Triggered");
    listOfExpenses.clear();
    try {
      listOfExpenses = await repo.getCurrentMonthExpenses();
      emit(ExpensesLoadedState(listOfExpenses));
    } on AppException catch (e) {
      e.print;
      emit(ExpensesErrorState(e));
    } catch (e) {
      ColoredLog.red(e, name: 'Load Expenses Error');
    }
  }

  FutureOr<void> _addExpenseEvent(
      ExpensesAddEvent event, Emitter<ExpensesState> emit) async {
    final ExpensesRepository repo = AppRepository().expensesRepository;
    ColoredLog.cyan('addExpenseEvent initiated', name: "Event Triggered");
    try {
      await repo.addExpense(event.expense);
      add(ExpensesLoadEvent());
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Load Expenses Error');
    }
  }

  FutureOr<void> _deleteExpenseEvent(
      ExpensesDeleteEvent event, Emitter<ExpensesState> emit) async {
    final ExpensesRepository repo = AppRepository().expensesRepository;
    ColoredLog.cyan('deleteExpenseEvent initiated', name: "Event Triggered");
    try {
      await repo.deleteExpense(event.expense);
      add(ExpensesLoadEvent());
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Load Expenses Error');
    }
  }

  FutureOr<void> _updateExpenseEvent(
      ExpensesUpdateEvent event, Emitter<ExpensesState> emit) async {
    final ExpensesRepository repo = AppRepository().expensesRepository;
    ColoredLog.cyan('updateExpenseEvent initiated', name: "Event Triggered");

    try {
      await repo.editExpenses(
        oldExpense: event.oldExpense,
        newExpense: event.newExpense,
      );
      add(ExpensesLoadEvent());
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Load Expenses Error');
    }
  }

  FutureOr<void> _loadExpensesCategory(
      ExpensesLoadCategoryEvent event, Emitter<ExpensesState> emit) async {
    final ExpensesRepository repo = AppRepository().expensesRepository;
    ColoredLog.cyan('loadExpensesCategory initiated', name: "Event Triggered");
    listOfCategoryExpenses.clear();
    try {
      List<Expenses> expenses = [];
      if (event.category == null) {
        expenses = await repo.getCurrentMonthExpenses();
      } else {
        expenses = await repo.fetchCategoryExpenses(event.category!);
      }

      listOfCategoryExpenses.addAll(expenses);
      emit(ExpensesLoadedState(listOfCategoryExpenses));
    } on AppException catch (e) {
      e.print;
      emit(ExpensesErrorState(e));
    } catch (e) {
      ColoredLog.red(e, name: 'Load Expenses Category Error');
    }
  }

  FutureOr<void> _searchExpensesEvent(
      ExpensesSearchEvent event, Emitter<ExpensesState> emit) {
    ColoredLog.cyan('searchExpensesEvent initiated', name: "Event Triggered");

    searchExpensesList.clear();
    List<Expenses> tempList = listOfExpenses
        .where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(event.searchText.toLowerCase()))
        .toList();
    searchExpensesList.addAll(tempList);
    emit(ExpensesLoadedState(listOfExpenses));
  }
}
