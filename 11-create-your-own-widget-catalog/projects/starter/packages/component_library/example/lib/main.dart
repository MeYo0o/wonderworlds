import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const ExampleApp(),
  );
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.grey,
      ),
    );
  }
}
