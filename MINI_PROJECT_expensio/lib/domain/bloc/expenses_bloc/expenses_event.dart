part of 'expenses_bloc.dart';

abstract class ExpensesEvent {}

class ExpensesLoadEvent extends ExpensesEvent {}

class ExpensesLoadCategoryEvent extends ExpensesEvent {
  final ExpenseCategory? category;

  ExpensesLoadCategoryEvent(this.category);
}

class ExpensesSearchEvent extends ExpensesEvent {
  final String searchText;

  ExpensesSearchEvent(this.searchText);
}

class ExpensesAddEvent extends ExpensesEvent {
  final Expenses expense;

  ExpensesAddEvent(this.expense);
}

class ExpensesDeleteEvent extends ExpensesEvent {
  final Expenses expense;

  ExpensesDeleteEvent(this.expense);
}

class ExpensesUpdateEvent extends ExpensesEvent {
  final Expenses newExpense;
  final Expenses oldExpense;

  ExpensesUpdateEvent({required this.newExpense, required this.oldExpense});
}
