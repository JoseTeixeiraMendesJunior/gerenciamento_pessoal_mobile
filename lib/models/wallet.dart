class WalletModel {
  double? total;
  double? expense;
  double? income;

  WalletModel({this.total, this.expense, this.income});

  WalletModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    expense = json['expense'];
    income = json['income'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['expense'] = expense;
    data['income'] = income;
    return data;
  }
}