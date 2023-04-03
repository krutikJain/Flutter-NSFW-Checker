import 'package:demoapp/model/HomeViewModel.dart';
import 'package:demoapp/view/NudityView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myViewModel = HomeViewModel(); // instantiate your ViewModel
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: myViewModel), // provide your ViewModel
      ],
      child: const MaterialApp(
        title: 'My App',
        home: HomePage(),
      ),
    );
  }
}
