import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:task_todo/layout/cubit/cubitB.dart';
import 'package:task_todo/shared/cubit/cubit.dart';
import 'package:task_todo/shared/cubit/cubitStates.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';
import 'layout/cubit/bloc_observer.dart';
import 'layout/newsapp/news_app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  bool isDark = CasheHelper.getData('isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AppCubit()..ChangeThemeMode(fromSharedPreferences: isDark),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..getBusinessData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: ThemeData(
                  textTheme: TextTheme(
                      body1: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black)),
                  primarySwatch: Colors.deepOrange,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange),
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.black),
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      elevation: 0,
                      backgroundColor: Colors.white)),
              darkTheme: ThemeData(
                  textTheme: TextTheme(
                      body1: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white)),
                  scaffoldBackgroundColor: HexColor('333739'),
                  primarySwatch: Colors.deepOrange,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.blueGrey,
                      backgroundColor: HexColor('333739')),
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.white),
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light,
                      ),
                      elevation: 0,
                      backgroundColor: HexColor('333739'))),
              home: NewsAppLayout());
        },
      ),
    );
  }
}
/**/
