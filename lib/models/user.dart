class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.profileImg,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
        id: data['id'], name: data['name'], email: data['email'], profileImg:data['profileImg']);
  }

  final String id;
  final String name;
  final String email;
  final String profileImg;
}