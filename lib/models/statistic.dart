class Statistic {
  late String key;
  late String title;
  late int value;
  late String rateString;

  Statistic(
      {required this.key,
      required this.title,
      required this.value,
      required this.rateString});

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

class DonateStatistic {
  late int total_donate;
  late int total_expense;
  DonateStatistic({required this.total_donate, required this.total_expense});
  DonateStatistic.fromJson(Map<String, dynamic> json) {
    total_donate = json['total_donate'];
    total_expense = json['total_expense'];
  }
}
