import 'package:blogit/helper/objectbox.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/state/objectbox_state.dart';

class BlogDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addBlog(Blog blog) async {
    try {
      return objectBoxInstance.addBlog(blog);
    } catch (e) {
      return 0;
    }
  }
}
