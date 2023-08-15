class TasksModel {
  String? name;
  String? dueDate;
  String? priority;
  String? type;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  TasksModel(
      {this.name,
      this.dueDate,
      this.priority,
      this.type,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  TasksModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dueDate = json['due_date'];
    priority = json['priority'];
    type = json['type'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['due_date'] = dueDate;
    data['priority'] = priority;
    data['type'] = type;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}