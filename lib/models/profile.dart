class Profile {
  late String id;
  late String created_at;
  late String? updated_at;
  late String name;
  late String address;
  late int age;
  late String? avatar;
  late String phone;
  late String email;
  late String occupation;

  Profile(
      {required this.id,
      required this.created_at,
      this.updated_at,
      required this.name,
      required this.address,
      required this.age,
      required this.avatar,
      required this.phone,
      required this.email,
      required this.occupation});

  factory Profile.fromJson(Map<String, dynamic> data) {
    return Profile(
        id: data['id'],
        created_at: data['created_at'],
        updated_at: data['updated_at'],
        name: data['name'],
        address: data['address'],
        age: data['age'],
        avatar: data['avatar'],
        email: data['email'],
        phone: data['phone'],
        occupation: data['occupation']);
  }
}
