class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String birthday;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.birthday,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        birthday = "";

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? birthday,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'birthday': birthday,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> map) {
    return UserProfileModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      birthday: map['birthday'],
    );
  }
}
