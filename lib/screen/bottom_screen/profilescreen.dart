import 'package:blogit/app/constants.dart';
import 'package:blogit/app/snackbar.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/repository/blog_respository.dart';
import 'package:blogit/repository/user_repository.dart';
import 'package:blogit/screen/bottom_screen/editBlogScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String route = "profileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<Blog>> _userblogs;
  late List<User> _userData;
  final _formKey = GlobalKey<FormState>();
  late Blog blog;

  @override
  void initState() {
    super.initState();
    setState(() {
      _userblogs = BlogRepositoryImpl().getAllUserBlog(Constant.userId);
    });
  }

  // _deleteBlog(Blog blog) async {
  //   int status = await BlogRepositoryImpl().deleteBlog(blog, Constant.userId);
  //   _showMessage(status);
  //   // _goToAnotherPage();
  // }

  _deleteBlog(Blog blog) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this blog?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                int status = await BlogRepositoryImpl()
                    .deleteBlog(blog, Constant.userId);
                _showMessage(status);
                setState(() {
                  _userblogs =
                      BlogRepositoryImpl().getAllUserBlog(Constant.userId);
                });
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  _showMessage(int status) {
    if (status > 0) {
      showSnackbar(context, 'Blog Deleted Successfully!', Colors.green);
    } else {
      showSnackbar(context, 'Error Deleting Blog', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double cardWidth =
                constraints.maxWidth < 750 ? constraints.maxWidth : 750;
            double titleFontSize = constraints.maxWidth < 600 ? 20 : 28;
            double contentFontSize = constraints.maxWidth < 600 ? 16 : 22;
            double viewFontSize = constraints.maxWidth < 600 ? 14 : 18;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: Ink.image(
                          image: const NetworkImage(
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
                          ),
                          fit: BoxFit.cover,
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: FutureBuilder(
                      future: UserRepositoryImpl().getUserData(Constant.userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final user = snapshot.data!;
                          return Column(
                            children: [
                              Text(
                                user[0].username!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                user[0].email!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'My Blogs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      key: _formKey,
                      child: FutureBuilder<List<Blog>>(
                        future: _userblogs,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Failed to load Blogs'),
                              );
                            }
                            final List<Blog>? blogs = snapshot.data;
                            if (blogs == null || blogs.isEmpty) {
                              return const Center(
                                child: Text('No blogs found'),
                              );
                            }
                            return Center(
                              child: SizedBox(
                                width: cardWidth,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: blogs.length,
                                  itemBuilder: (context, index) {
                                    final Blog blog = blogs[index];
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Card(
                                        color: const Color(0xF5F5F5F5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: Text(
                                              blog.title ?? '',
                                              style: TextStyle(
                                                  fontSize: titleFontSize),
                                            ),
                                          ),
                                          subtitle: Text(
                                            blog.content ?? '',
                                            style: TextStyle(
                                                fontSize: contentFontSize),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  Navigator.pushNamed(
                                                    context,
                                                    EditBlogScreen.route,
                                                    arguments: blog,
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: MediaQuery.of(context)
                                                              .size
                                                              .width >
                                                          600
                                                      ? 40
                                                      : 30,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _deleteBlog(blog);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: MediaQuery.of(context)
                                                              .size
                                                              .width >
                                                          600
                                                      ? 40
                                                      : 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
