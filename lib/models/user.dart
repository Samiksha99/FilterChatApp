class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
        id: data['id'], name: data['name'], email: data['email']);
  }

  final String id;
  final String name;
  final String email;
}