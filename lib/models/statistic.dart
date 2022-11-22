class Statistic {
  String? key;
  String? title;
  int? value;
  String? rateString;

  Statistic({this.key, this.title, this.value, this.rateString});

  Statistic.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
    value = json['value'];
    rateString = json['rateString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['title'] = this.title;
    data['value'] = this.value;
    data['rateString'] = this.rateString;
    return data;
  }
}
