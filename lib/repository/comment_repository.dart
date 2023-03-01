import 'package:blogit/app/network_connectivity.dart';
import 'package:blogit/data_source/local_data_source/blog_data_source.dart';
import 'package:blogit/data_source/local_data_source/comment_data_source.dart';
import 'package:blogit/data_source/remote_data_source/comment_data_source.dart';
import 'package:blogit/model/comment.dart';

abstract class CommentRepository {
  Future<int> createComment(String blogId, String comment);
  Future<List<Comment>> getAllComment(String blogId);
}

class CommentRepositoryImpl extends CommentRepository {
  @override
  Future<int> createComment(String blogId, String comment) {
    return CommentRemoteDataSource().createComment(blogId, comment);
  }

  @override
  Future<List<Comment>> getAllComment(String blogId) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return CommentRemoteDataSource().getAllComment(blogId);
    } else {
      return CommentDataSource().getAllComment(blogId);
    }
  }
}
