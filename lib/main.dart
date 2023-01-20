import 'package:flutter/material.dart';
import 'package:interview/provider/allProvider.dart';
import 'package:interview/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Interview Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'The Interview'),
      ),
    );
  }
}
