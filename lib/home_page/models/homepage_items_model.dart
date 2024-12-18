class HomePageItems {
  String? status;
  List<HomeListItems>? result;

  HomePageItems({this.status, this.result});

  HomePageItems.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <HomeListItems>[];
      json['result'].forEach((v) {
        result!.add(new HomeListItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeListItems {
  String? name;
  String? amount;
  String? image;

  HomeListItems({this.name, this.amount, this.image});

  HomeListItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['image'] = this.image;
    return data;
  }
}
