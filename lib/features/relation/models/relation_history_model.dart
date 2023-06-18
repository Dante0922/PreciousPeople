import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repos/relation_history_repo.dart';

class RelationHistoryModel{
  String friendId;
  String startDate;
  String endDate;

  RelationHistoryModel({
    required this.friendId,
    required this.startDate,
    required this.endDate,
  });

  RelationHistoryModel copyWith({
    String? friendId,
    String? startDate,
    String? endDate,
  }) {
    return RelationHistoryModel(
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

  factory RelationHistoryModel.fromJson(Map<String, dynamic> map) {
    return RelationHistoryModel(
      friendId: map['friendId'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
    );
  }
}

