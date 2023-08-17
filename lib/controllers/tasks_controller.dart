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
  TextEditingController description = TextEditingController();
  TextEditingController status = TextEditingController();


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
  createTask() async {
    changeLoading(true);
    TasksModel data = TasksModel(
      name: name.text,
      priority: priority.text,
      dueDate: dueDate.text,
      description: description.text,
      type: "only",
    );
    
    TasksModel res = await rep.createTasks(data.toJson());

    if(res.id != null ) {
      print('oi');
      tasks.add(res);
    }
    changeLoading(false);

    return res.id != null;
  }

    @action
    updateTask(int id) async {
      changeLoading(true);
      TasksModel data = TasksModel(
        id: id,
        name: name.text,
        priority: priority.text,
        dueDate: dueDate.text,
        description: description.text,
        status: status.text,
        type: "only",
      );
      
      TasksModel res = await rep.updateTasks(id, data.toJson());

      if(res.id != null) {
        print('oi');
        tasks.removeWhere((element) => element.id == data.id);
        tasks.add(res);
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

  disposeTransaction() {
    name.clear();
    description.clear();
    dueDate.clear();
    priority.clear();
  }

  withTransaction(TasksModel tasksModel) {
    name.text = tasksModel.name ?? '';
    description.text = tasksModel.description ?? '';
    dueDate.text = tasksModel.dueDate ?? '';
    priority.text = tasksModel.priority ?? '';
  }

  Color getStatusColor(String status) {
    switch(status) {
      case 'todo':
        return Colors.grey;
      case 'in_progress':
        return Colors.amber;
      case 'done':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch(status) {
      case 'todo':
        return Icons.hourglass_empty_rounded;
      case 'in_progress':
        return Icons.note_alt;
      case 'done':
        return Icons.check_circle;
      default:
        return Icons.hourglass_empty_rounded;
    }
  }
}