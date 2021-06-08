import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_bloc.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_module.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';

class SprintNewWidget extends StatefulWidget {
  @override
  _SprintNewWidgetState createState() => _SprintNewWidgetState();
}

class _SprintNewWidgetState extends State<SprintNewWidget> {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _link = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incluir Sprint'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  _nome = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Link é obrigatório';
                  }
                  _link = value;
                  return null;
                },
              ),
              TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        bool result =
                            await _bloc.doAdd(Sprint(nome: _nome, link: _link));
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Sprint salva com sucesso!'),
                            backgroundColor: Colors.green,
                          ));
                          _bloc.doFetch();
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${error}'),
                          backgroundColor: Colors.red,
                        ));
                      }
                      return Navigator.pop(context);
                    }
                  },
                  child: Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}
