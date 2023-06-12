class RelationHistory{
  String friendId;
  String startDate;
  String endDate;

  RelationHistory({
    required this.friendId,
    required this.startDate,
    required this.endDate,
  });

  RelationHistory copyWith({
    String? friendId,
    String? startDate,
    String? endDate,
  }) {
    return RelationHistory(
      friendId: friendId ?? this.friendId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'friendId': friendId,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory RelationHistory.fromJson(Map<String, dynamic> map) {
    return RelationHistory(
      friendId: map['friendId'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
    );
  }
}