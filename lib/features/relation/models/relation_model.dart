class RelationModel{
  String registerUserId;
  String friendId;
  String startDate;
  String endDate;
  String period;
  String lastContact;


  RelationModel({
    required this.registerUserId,
    required this.friendId,
    required this.startDate,
    required this.endDate,
    required this.period,
    required this.lastContact,
  });

  RelationModel copyWith({
    String? registerUserId,
    String? friendId,
    String? startDate,
    String? endDate,
    String? period,
    String? lastContact,
  }) {
    return RelationModel(
      registerUserId: registerUserId ?? this.registerUserId,
      friendId: friendId ?? this.friendId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      period: period ?? this.period,
      lastContact: lastContact ?? this.lastContact,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registerUserId': registerUserId,
      'friendId': friendId,
      'startDate': startDate,
      'endDate': endDate,
      'period': period,
      'lastContact': lastContact,
    };
  }

  factory RelationModel.fromJson(Map<String, dynamic> map) {
    return RelationModel(
      registerUserId: map['registerUserId'] as String,
      friendId: map['friendId'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      period: map['period'] as String,
      lastContact: map['lastContact'] as String,
    );
  }
}