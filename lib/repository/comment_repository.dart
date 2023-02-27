import 'package:blogit/data_source/remote_data_source/comment_data_source.dart';
import 'package:blogit/model/comment.dart';

abstract class CommentRepository {
  Future<int> createComment(String blogId, Comment comment);
}

class CommentRepositoryImpl extends CommentRepository {
  @override
  Future<int> createComment(String blogId, Comment comment) {
    return CommentRemoteDataSource().createComment(blogId, comment);
  }
}
