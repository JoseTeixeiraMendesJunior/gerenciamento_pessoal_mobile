import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/tasks_controller.dart';
import 'package:gerenciamento_pessoal_mobile/models/tasks_model.dart';
import 'package:get_it/get_it.dart';

import '../../resources/global_colors.dart';

class TasksForm extends StatefulWidget {
  const TasksForm({
      required this.typeRequest,
      this.task,
      super.key
    });

  final TasksModel? task;
  final String typeRequest;

  @override
  State<TasksForm> createState() => _TasksFormState();
}

class _TasksFormState extends State<TasksForm> {
  final TasksController tasksController = GetIt.I.get<TasksController>();
  DateTime? _selectedTime;
  int? groupValue;
  int? groupStatus;

  @override
  void initState() {
    _selectedTime = null;
    tasksController.disposeTransaction();
    if(widget.task != null) {
      tasksController.withTransaction(widget.task!);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: GlobalColors.navy,
        title: const Text('Nova Transação', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, right: 32, left: 32),
              child: TextField(
                decoration: const InputDecoration(hintText: 'Nome'),
                controller: tasksController.name,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32, left: 32),
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Descrição'),
                controller: tasksController.description,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 32, left: 32),
              child: GestureDetector(
                onTap: () async {
                  _selectedTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                    currentDate: DateTime.now(),
                    builder: (BuildContext context, Widget? child) =>
                        Theme(
                      data: ThemeData().copyWith(
                          colorScheme: const ColorScheme.light(
                              primary: GlobalColors.navy)),
                      child: child!,
                    ),
                  );

                  if (_selectedTime != null) {
                    setState(() {
                      tasksController.dueDate.text =
                          '${_selectedTime!.year}-${_selectedTime!.month}-${_selectedTime!.day}';
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: tasksController.dueDate,
                    decoration: InputDecoration(
                        hintText: 'Conclusão',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: GlobalColors.navy,
                                width: 3))),
                  ),
                ),
              )),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                      child: Text(
                        'Prioridade',
                        style: TextStyle(
                            color: Colors.black, fontSize: 16),
                      ),
                    ),
                    CupertinoSlidingSegmentedControl<int>(
                      thumbColor: GlobalColors.navy,
                      padding: const EdgeInsets.all(4),
                      groupValue: groupValue,
                      children: {
                        0: escalaItem('Baixa', groupValue == 0? Colors.white : Colors.black),
                        1: escalaItem('Média', groupValue == 1? Colors.white : Colors.black),
                        2: escalaItem('Alta', groupValue == 2? Colors.white : Colors.black),
                      },
                      onValueChanged: (value) => setState(() {
                        groupValue = value;
                        switch(value) {
                          case 0 :
                            tasksController.priority.text = 'low';
                            break;
                          case 1 :
                            tasksController.priority.text = 'medium';
                          case 2 :
                            tasksController.priority.text = 'high';
                        }
                      }),
                    ),
                  ],
                ),
              ),
              widget.typeRequest == 'update' ?
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                      child: Text(
                        'Status',
                        style: TextStyle(
                            color: Colors.black, fontSize: 16),
                      ),
                    ),
                    CupertinoSlidingSegmentedControl<int>(
                      thumbColor: GlobalColors.navy,
                      padding: const EdgeInsets.all(4),
                      groupValue: groupStatus,
                      children: {
                        0: escalaItem('Aberto', groupStatus == 0? Colors.white : Colors.black),
                        1: escalaItem('Andamento', groupStatus == 1? Colors.white : Colors.black),
                        2: escalaItem('Finalizada', groupStatus == 2? Colors.white : Colors.black),
                      },
                      onValueChanged: (value) => setState(() {
                        groupStatus = value;
                        switch(value) {
                          case 0 :
                            tasksController.status.text = 'todo';
                            break;
                          case 1 :
                            tasksController.status.text = 'in_progress';
                          case 2 :
                            tasksController.status.text = 'done';
                        }
                      }),
                    ),                        
                  ],
                ),
              ) : const SizedBox(),
           
            Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    bool res =  widget.typeRequest ==  'create' ?
                    await tasksController.createTask() :
                    await tasksController.updateTask(widget.task!.id!);

                    if(res == true && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Salvar'),
              )
            ),
      ],
        )
    );
  }

Widget escalaItem(String text, Color color) => Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: color),
      ),
    );
}