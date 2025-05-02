import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture_example/presentation/providers/providers.dart';
import 'package:flutter_mvvm_architecture_example/presentation/views/data_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Async Demo',
      home: DataScreen(),
    );
  }
}