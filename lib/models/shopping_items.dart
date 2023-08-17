class ShopItems {
  String? name;
  int? quantity;
  bool? selected;

  ShopItems({this.name, this.quantity, this.selected});

  ShopItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['selected'] = selected;
    return data;
  }
}