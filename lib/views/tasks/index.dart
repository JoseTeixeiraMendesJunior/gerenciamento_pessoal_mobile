import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/tasks_controller.dart';
import 'package:gerenciamento_pessoal_mobile/models/tasks_model.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:gerenciamento_pessoal_mobile/views/tasks/form.dart';
import 'package:get_it/get_it.dart';

import '../../resources/widgets/comuns.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  final TasksController tasksController = GetIt.I.get<TasksController>();

  @override
  void initState() {
    tasksController.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Lista de Tarefas', style: TextStyle(color: Colors.white),),
            ],
          ),
          backgroundColor: GlobalColors.navy,
        ),
        body: Column(
          children: [
              if(tasksController.isLoading)
                ...[const Center(child: LoadingWidget())]
              else if(tasksController.tasks.isEmpty) 
                ...[const Center(child: EmptyWidget())]
              else ...[TasksBody(
                tasks: tasksController.tasks,
                tasksController: tasksController,
                )],
      
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const TasksForm(typeRequest: 'create',))),
          backgroundColor: GlobalColors.navy,
          elevation: 5,
          child: const Icon(Icons.add, color: Colors.white,),
          ),
      );
    });
  }
}

class TasksBody extends StatelessWidget {
  const TasksBody({
      required this.tasks,
      required this.tasksController,
      super.key
    });

    final List<TasksModel> tasks;
    final TasksController tasksController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          ...tasks.map((element) {
            return TasksElement(task: element, tasksController: tasksController,);
          })
        ],
      )
    );
  }
}

class TasksElement extends StatelessWidget {
  const TasksElement({
      required this.task,
      required this.tasksController,
      super.key
    });

  final TasksModel task;
  final TasksController tasksController;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => 
              TasksForm(typeRequest: 'update', task: task),));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: GlobalColors.navy, width: 3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(tasksController.getStatusIcon(task.status!), color: tasksController.getStatusColor(task.status!),),
                Column(
                  children: [
                    Text(task.name ?? ''),
                    Text.rich(
                      TextSpan(
                        text: 'Itens: ',
                        children: [TextSpan(text: task.name)] 
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await tasksController.removeShoppingList(task.id!);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red,))
              ],
            )
          ),
        ),
      );
  }
}