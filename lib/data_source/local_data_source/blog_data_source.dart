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

  Future addAllBlog(List<Blog> lstBlog) async {
    try {
      return objectBoxInstance.addAllBlog(lstBlog);
    } catch (e) {
      return false;
    }
  }

  Future<List<Blog>> getAllBlog() async {
    try {
      return Future.value(objectBoxInstance.getAllBlogs());
    } catch (e) {
      return [];
    }
  }

  Future<Blog?> getABlog(String blogId) async {
    try {
      return objectBoxInstance.getABlog(blogId);
    } catch (e) {
      return null;
    }
  }
}
