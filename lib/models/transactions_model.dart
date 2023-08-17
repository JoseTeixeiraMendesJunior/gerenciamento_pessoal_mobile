class TransactionModel {
  int? id;
  String? description;
  double? amount;
  String? type;
  String? date;
  String? category;

  TransactionModel(
      {this.id,
      this.description,
      this.amount,
      this.type,
      this.date,
      this.category});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    amount = json['amount'];
    type = json['type'];
    date = json['date'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['amount'] = amount;
    data['type'] = type;
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}