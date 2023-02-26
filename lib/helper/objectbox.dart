import 'package:blogit/model/blog.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;
  late final Box<Blog> _blog;

  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
    _blog = Box<Blog>(_store);
  }

  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/user_blog',
    );
    return ObjectBoxInstance(store);
  }

  int addBlog(Blog blog) {
    return _blog.put(blog);
  }

  List<Blog> getAllBlogs() {
    return _blog.getAll();
  }

  int addUser(User user) {
    return _user.put(user);
  }

  List<User> getAllUser() {
    return _user.getAll();
  }

  User? loginUser(String username, String password) {
    return _user
        .query(
            User_.username.equals(username) & User_.password.equals(password))
        .build()
        .findFirst();
  }
}
