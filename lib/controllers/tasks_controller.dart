import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/models/tasks_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../repositories/global_api.dart';
part 'tasks_controller.g.dart';

class TasksController = _TasksControllerBase with _$TasksController;

abstract class _TasksControllerBase with Store {
  final GlobalApi rep = GetIt.I.get<GlobalApi>();

  TextEditingController name = TextEditingController();
  TextEditingController priority = TextEditingController();
  TextEditingController dueDate = TextEditingController();

  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  ObservableList<TasksModel> tasks = ObservableList<TasksModel>();

  @action
  getTasks() async {
    changeLoading(true);
    List<TasksModel> temp = await rep.getTasks();
    tasks = temp.asObservable();
    changeLoading(false);
  }

  @action
  createTask(String method, {int? id}) async {
    changeLoading(true);
    TasksModel data = TasksModel(
      id: id,
      name: name.text,
      priority: priority.text,
      dueDate: dueDate.text,
    );
    
    TasksModel res = await rep.createTasks(data.toJson());

    if(res.id != null ) {
      tasks.insert(0, res);
    }
    changeLoading(false);

    return res.id != null;
  }

  @action
  removeShoppingList(int id) async {
    changeLoading(true);
    bool res = await rep.deleteTasks(id);
    changeLoading(false);
    tasks.removeWhere((element) => element.id == id);
    return res;
  }
}