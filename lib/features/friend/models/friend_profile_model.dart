class FriendProfileModel {
  final String registerUserId;
  final String friendId;
  final String name;
  final String friendaversery;
  final String contact;
  final bool hasAvatar;
  final String imageUrl;
  final bool isLiked;

  FriendProfileModel({
    required this.registerUserId,
    required this.name,
    required this.friendId,
    required this.friendaversery,
    required this.contact,
    required this.hasAvatar,
    required this.imageUrl,
    required this.isLiked,
  });

  Map<String, dynamic> toJson() {
    return {
      "registerUserId": registerUserId,
      "friendId":friendId,
      'name': name,
      'friendaversery': friendaversery,
      'contact': contact,
      'hasAvatar': hasAvatar,
      'imageUrl': imageUrl,
      'isLiked': isLiked,
    };
  }

  FriendProfileModel.fromJson(
       Map<String, dynamic> json)
      : registerUserId = json['registerUserId'],
        friendId = json['friendId'] ?? "",
        name = json['name'],
        friendaversery = json['friendaversery'],
        contact = json['contact'],
        hasAvatar = json['hasAvatar'] ?? false,
        imageUrl = json['imageUrl'],
        isLiked = json['isLiked'] ?? false;

  FriendProfileModel copyWith({
    String? registerUserId,
    String? friendId,
    String? name,
    String? friendaversery,
    String? contact,
    bool? hasAvatar,
    String? imageUrl,
    bool? isLiked,
  }) {
    return FriendProfileModel(
      registerUserId: registerUserId ?? this.registerUserId,
      friendId: friendId ?? this.friendId,
      name: name ?? this.name,
      friendaversery: friendaversery ?? this.friendaversery,
      contact: contact ?? this.contact,
      hasAvatar: hasAvatar ?? this.hasAvatar,
      imageUrl: imageUrl ?? this.imageUrl,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
