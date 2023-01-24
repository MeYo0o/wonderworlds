import 'package:component_library_storybook/story_app.dart';
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
    return StoryApp();
  }
}
