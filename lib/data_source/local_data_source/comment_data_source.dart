import 'package:blogit/helper/objectbox.dart';
import 'package:blogit/model/comment.dart';
import 'package:blogit/state/objectbox_state.dart';

class CommentDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<List<Comment>> getAllComment(String blogId) async {
    try {
      return Future.value(objectBoxInstance.getAllComment(blogId));
    } catch (e) {
      return [];
    }
  }
}
