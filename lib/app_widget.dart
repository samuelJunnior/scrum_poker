import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_new_widget.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_module.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_widget.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        home: SprintModule(),
        routes: <String, WidgetBuilder>{
          "/sprintNew": (BuildContext context) => SprintNewWidget(),
          "/sprint": (BuildContext context) => SprintWidget(),
        });
  }
}
