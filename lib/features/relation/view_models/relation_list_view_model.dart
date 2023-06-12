
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/repos/authentication_repo.dart';
import '../models/relation_model.dart';
import '../repos/relation_repo.dart';

class RelationViewModel extends AsyncNotifier<List<RelationModel>> {
  late final RelationshipRepository _relationRepository;
  late final AuthenticationRepository _auth;
  List<RelationModel> _list = [];

  @override
  FutureOr<List<RelationModel>> build() {
    _auth = ref.read(authRepo);
    _relationRepository = ref.read(relationRepo);
    _list = _fetchRelations(_auth.user!.uid) as List<RelationModel>;
    return _list;
  }

  Future<List<RelationModel>> _fetchRelations(String userId) async {
    final snapshot = await _relationRepository.fetchRelations(userId);
    return snapshot.docs.map((e) => RelationModel.fromJson(e.data())).toList();
  }
}