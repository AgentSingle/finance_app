import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/pages/HomePage.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: blueSecondary,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: blueDeep,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: bluePrimary),
        useMaterial3: true,
      ),
      home: const Scaffold(
        backgroundColor: bluePrimary,
        body: SafeArea(
          child: appBackgroundContainer(
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}