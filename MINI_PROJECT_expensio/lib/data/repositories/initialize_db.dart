import 'package:hive_flutter/hive_flutter.dart';

import '/data/repositories/common_interfaces/expenses_repo_interface.dart';
import '/data/repositories/local/config_repo/hive_config_repo.dart';
import '/data/models/expenses_model.dart';
import '/core/utils/colored_log.dart';

class InitializeDb {
  static Future<void> initLocalDb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpensesAdapter());

    try {
      await Hive.openBox(HiveConfigRepository.configBox);
      await Hive.openBox<Expenses>(ExpensesRepository.expensesCollection);
    } catch (e) {
      ColoredLog.red(e, name: "Init Hive Error");
    }
  }
}
