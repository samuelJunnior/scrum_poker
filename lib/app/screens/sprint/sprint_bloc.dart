import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_api.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';

class SprintBloc extends BlocBase {
  final SprintApi _api;
  SprintBloc(this._api);

  late final _sprintFetcher = PublishSubject<List<Sprint>>();
  late final _sprintAdd = PublishSubject<bool>();
  late final _sprintRemove = PublishSubject<bool>();

  late final _loading = BehaviorSubject<bool>();

  Stream<List<Sprint>> get sprint => _sprintFetcher.stream;
  Stream<bool> get sprintAdd => _sprintAdd.stream;
  Stream<bool> get sprintRemove => _sprintRemove.stream;

  Stream<bool> get loading => _loading.stream;

  doFetch() async {
    _loading.sink.add(true);

    final posts = await _api.fetchSprints();

    _sprintFetcher.sink.add(posts);
    _loading.sink.add(false);
  }

  doAdd(sprint) async {
    _loading.sink.add(true);

    final success = await _api.adicionarSprint(sprint);

    _sprintAdd.sink.add(success);
    _loading.sink.add(false);

    return success;
  }

  doRemove(id) async {
    _loading.sink.add(true);

    final success = await _api.deletarSprint(id);

    _sprintAdd.sink.add(success);
    _loading.sink.add(false);

    return success;
  }

  @override
  void dispose() {
    _sprintFetcher.close();
    _sprintAdd.close();
    _sprintRemove.close();
    _loading.close();
    super.dispose();
  }
}
