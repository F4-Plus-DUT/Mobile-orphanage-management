class Donor {
  late String? id;
  late String? created_at;
  late String? note;
  late String? donor;
  late int? amount;

  Donor({this.id, this.created_at, this.note, this.donor, this.amount});

  factory Donor.fromJson(Map<String, dynamic> data) {
    return Donor(
        id: data['id'],
        created_at: data['created_at'],
        note: data['note'],
        donor: data['donor'],
        amount: data['amount']);
  }
}
