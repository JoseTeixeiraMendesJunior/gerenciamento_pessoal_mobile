class TasksModel {
  String? name;
  String? dueDate;
  String? priority;
  String? type;
  int? id;

  TasksModel(
      {this.name,
      this.dueDate,
      this.priority,
      this.type,
      this.id});

  TasksModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dueDate = json['due_date'];
    priority = json['priority'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['due_date'] = dueDate;
    data['priority'] = priority;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}