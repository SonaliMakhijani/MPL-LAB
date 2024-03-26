part of 'expenses_bloc.dart';

abstract class ExpensesState {}

class ExpensesInitialState extends ExpensesState {}

class ExpensesLoadingState extends ExpensesState {}

class ExpensesErrorState extends ExpensesState {
  final AppException exception;
  ExpensesErrorState(this.exception);
}

class ExpensesLoadedState extends ExpensesState {
  final List<Expenses> listOfExpenses;
  ExpensesLoadedState(this.listOfExpenses);
}
