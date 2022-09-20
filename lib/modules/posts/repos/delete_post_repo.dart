

import '../../../resources/delete_repo.dart';

class DeletePostRepo extends DeleteRepo{
  final String postId;

  DeletePostRepo(this.postId);

  @override
  String get url => '/posts/$postId';
}