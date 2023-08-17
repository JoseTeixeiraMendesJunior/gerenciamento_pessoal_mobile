import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/financial_controller.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/login_controller.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/shopping_controller.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/shopping_list_controller.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/tasks_controller.dart';
import 'package:gerenciamento_pessoal_mobile/provider/global_request.dart';
import 'package:gerenciamento_pessoal_mobile/repositories/global_api.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_scafold.dart';
import 'package:gerenciamento_pessoal_mobile/views/home/index.dart';
import 'package:gerenciamento_pessoal_mobile/views/login/index.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton<GlobalProvider>(() => GlobalProvider());
  getIt.registerLazySingleton<GlobalApi>(() => GlobalApi());
  getIt.registerLazySingleton<LoginController>(() => LoginController());
  getIt.registerLazySingleton<ShoppingController>(() => ShoppingController());
  getIt.registerLazySingleton<FinancialController>(() => FinancialController(),);
  getIt.registerLazySingleton<ShoppingListController>(() => ShoppingListController(),);
  getIt.registerLazySingleton<TasksController>(() => TasksController(),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return MaterialApp(
        builder: (context, child) => GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ScaffoldMessenger(
                key: GlobalScaffold.instance.scaffoldMessengerKey,
                child: child!)),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
            fontFamily: 'Montserrat',
            primaryColor: GlobalColors.navy,
            scaffoldBackgroundColor: GlobalColors.white,
            appBarTheme:
                const AppBarTheme(backgroundColor: GlobalColors.navy, iconTheme: IconThemeData(color: Colors.white)),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                minimumSize: const Size(152, 56),
                shape: const StadiumBorder(),
                backgroundColor: GlobalColors.navy,
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    GlobalColors.blue,
                  ),
                  side: MaterialStateProperty.all(const BorderSide(
                      color: GlobalColors.blue,
                      width: 1.0,
                      style: BorderStyle.solid))),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: GlobalColors.maroon),
            primarySwatch: Colors.blue,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              alignLabelWithHint: true,
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),//LoginView(),
        });
  }
}
