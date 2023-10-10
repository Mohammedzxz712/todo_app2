class UserModel {
  String name;
  String id;
  String phone;
  String email;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          phone: json['phone'],
          email: json['email'],
          id: json['id'],
        );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'name': name,
      'id': id,
    };
  }
}
