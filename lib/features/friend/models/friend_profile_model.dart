class FriendProfileModel {
  final String registerUserId;
  final String friendId;
  final String name;
  final String friendaversery;
  final String contact;
  final String thumbnailUrl;
  final String imageUrl;
  final bool isLiked;

  FriendProfileModel({
    required this.registerUserId,
    required this.name,
    required this.friendId,
    required this.friendaversery,
    required this.contact,
    required this.thumbnailUrl,
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
      'thumbnailUrl': thumbnailUrl,
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
        thumbnailUrl = json['thumbnailUrl'],
        imageUrl = json['imageUrl'],
        isLiked = json['isLiked'];
}
