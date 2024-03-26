import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/expenses_bloc/expenses_bloc.dart';
import '/domain/bloc/config_bloc/config_bloc.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/screens/splash/splash.dart';
import '/data/repositories/initialize_db.dart';
import '/core/config/app_themes.dart';
import 'core/config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC2GZRuNG9Lg8W3Y1Pv_C-MRRimGWK-2cQ",
        appId: "1:776341054403:android:264dea5b47b8f304ae1376",
        messagingSenderId: "776341054403",
        projectId: "expensetracker-27e5a",
        storageBucket: "expensetracker-27e5a.appspot.com",
      ),
    );
  await InitializeDb.initLocalDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthEventCheckLoggedInUser()),
        ),
        BlocProvider(
          create: (context) => ConfigBloc()..add(ConfigGetEvent()),
        ),
        BlocProvider(create: (context) => ExpensesBloc()),
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) => MaterialApp(
          title: 'Expensio',
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: context.watch<ConfigBloc>().themeMode,
        ),
      ),
    );
  }
}
