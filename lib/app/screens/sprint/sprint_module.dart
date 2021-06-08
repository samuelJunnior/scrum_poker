import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_api.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_bloc.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_widget.dart';
import 'package:scrum_poker/app_module.dart';

class SprintModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SprintBloc(i.get<SprintApi>())),
      ];

  @override
  Widget get view => SprintWidget();

  @override
  List<Dependency> get dependencies =>
      [Dependency((i) => SprintApi(AppModule.to.getDependency<Client>()))];

  static Inject get to => Inject<SprintModule>.of();
}
