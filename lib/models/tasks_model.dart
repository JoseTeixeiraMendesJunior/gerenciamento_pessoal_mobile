class TasksModel {
  int? id;
  String? name;
  String? dueDate;
  String? priority;
  String? status;
  String? type;
  String? description;
  String? completedAt;

  TasksModel(
      {this.id,
      this.name,
      this.dueDate,
      this.priority,
      this.status,
      this.type,
      this.description,
      this.completedAt});

  TasksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dueDate = json['due_date'];
    priority = json['priority'];
    status = json['status'];
    type = json['type'];
    description = json['description'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['due_date'] = dueDate;
    data['priority'] = priority;
    data['status'] = status;
    data['type'] = type;
    data['description'] = description;
    data['completed_at'] = completedAt;
    return data;
  }
}