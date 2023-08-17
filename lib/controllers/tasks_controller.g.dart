// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TasksController on _TasksControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_TasksControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$tasksAtom =
      Atom(name: '_TasksControllerBase.tasks', context: context);

  @override
  ObservableList<TasksModel> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TasksModel> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$getTasksAsyncAction =
      AsyncAction('_TasksControllerBase.getTasks', context: context);

  @override
  Future getTasks() {
    return _$getTasksAsyncAction.run(() => super.getTasks());
  }

  late final _$createTaskAsyncAction =
      AsyncAction('_TasksControllerBase.createTask', context: context);

  @override
  Future createTask(String method, {int? id}) {
    return _$createTaskAsyncAction.run(() => super.createTask(method, id: id));
  }

  late final _$removeShoppingListAsyncAction =
      AsyncAction('_TasksControllerBase.removeShoppingList', context: context);

  @override
  Future removeShoppingList(int id) {
    return _$removeShoppingListAsyncAction
        .run(() => super.removeShoppingList(id));
  }

  late final _$_TasksControllerBaseActionController =
      ActionController(name: '_TasksControllerBase', context: context);

  @override
  dynamic changeLoading(dynamic value) {
    final _$actionInfo = _$_TasksControllerBaseActionController.startAction(
        name: '_TasksControllerBase.changeLoading');
    try {
      return super.changeLoading(value);
    } finally {
      _$_TasksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tasks: ${tasks}
    ''';
  }
}
