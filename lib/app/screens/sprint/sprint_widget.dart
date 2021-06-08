import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_bloc.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_module.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';

class SprintWidget extends StatelessWidget {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  @override
  Widget build(BuildContext context) {
    _bloc.doFetch();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/sprintNew");
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: _bloc.sprint,
        builder: (_, AsyncSnapshot<List<Sprint>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final sprint = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.list),
                  ),
                  title: Text(sprint.nome),
                  subtitle: Text(sprint.link),
                  trailing: Container(
                    width: 50,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                          'Deseja excluir a sprint ${sprint.nome}'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Não')),
                                        TextButton(
                                            onPressed: () async {
                                              try {
                                                bool result = await _bloc
                                                    .doRemove(sprint.id);
                                                if (result) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Sprint excluída com sucesso!'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ));
                                                  _bloc.doFetch();
                                                  Navigator.pop(context);
                                                }
                                              } catch (error) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text('${error}'),
                                                  backgroundColor: Colors.red,
                                                ));
                                              }
                                            },
                                            child: Text('Sim'))
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(),
            );
          }

          return StreamBuilder(
            stream: _bloc.loading,
            builder: (_, AsyncSnapshot<bool> snapshot) {
              final loading = snapshot.data ?? false;
              if (loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
