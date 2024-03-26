import '/core/utils/colored_log.dart';
import '/data/repositories/local/config_repo/hive_config_repo.dart';
import '/data/repositories/local/expenses_repo/hive_expenses_repo.dart';
import '/data/repositories/remote/expenses_repo/firebase_expenses_repo.dart';
import 'remote/auth_repository/firebase_auth_repo.dart';
import 'remote/user_repository/firebase_user_repository.dart';

enum DatabaseType {
  local,
  remote,
}

class AppRepository {
  static DatabaseType dbType = DatabaseType.remote; // Change to remote by default

  get authRepository {
    return FirebaseAuthRepository();
  }

  get userRepository {
    return FirebaseUserRepository();
  }

  get configRepository {
    return HiveConfigRepository();
  }

  get expensesRepository {
    if (dbType == DatabaseType.remote) { // Check if remote is selected
      ColoredLog.cyan('remote db returning');
      return FirebaseExpensesRepository();
    } else {
      ColoredLog.cyan('local db returning');
      return HiveExpensesRepository();
    }
  }

  /// Singleton factory Constructor
  AppRepository._internal();
  static final AppRepository _instance = AppRepository._internal();
  factory AppRepository() {
    return _instance;
  }
}
