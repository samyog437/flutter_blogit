import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:blogit/app/constants.dart';
import 'package:blogit/app/snackbar.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/model/comment.dart';
import 'package:blogit/repository/comment_repository.dart';
import 'package:blogit/screen/bottom_screen/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key});

  static const String route = "blogDetailScreen";

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  late Blog blog;
  final _commentController = TextEditingController();
  final double distanceThreshold = 5.0;
  late StreamSubscription<ProximityEvent> _proximitySubscription;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _proximitySubscription = proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        if (event.proximity < distanceThreshold) {
          Navigator.pushReplacementNamed(context, DashboardScreen.route);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _proximitySubscription.cancel();
  }

  @override
  void didChangeDependencies() {
    blog = ModalRoute.of(context)!.settings.arguments as Blog;
    _loadComments();
    super.didChangeDependencies();
  }

  _loadComments() async {
    List<Comment> comments =
        await CommentRepositoryImpl().getAllComment(blog.blogId!);
    setState(() {
      blog.comments = comments;
    });
  }

  _addComment() async {
    // Comment comment = Comment(
    //   body: _commentController.text,
    // );
    int status = await CommentRepositoryImpl()
        .createComment(blog.blogId!, _commentController.text);
    _showMessage(status);
  }

  _showMessage(int status) {
    if (status > 0) {
      setState(() {
        _commentController.clear();
        _loadComments();
      });

      showSnackbar(context, 'Blog Added Successfully!', Colors.green);
    } else {
      showSnackbar(context, 'Error Adding Blog', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    // blog.view++;
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title!),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  blog.image != null
                      ? Image.network(
                          Constant.blogImageURL + blog.image!,
                          height: constraints.maxWidth * 0.5,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    blog.title!,
                    style: const TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'By ${blog.user?.username}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    blog.content!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _commentController,
                          maxLines: null,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            hintText: 'Add a Comment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addComment();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFad5389)),
                          ),
                          child: const Text(
                            'Add Comment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: blog.comments!.length,
                    itemBuilder: (context, index) {
                      var comment = blog.comments![index];
                      final dateTime = DateTime.parse(comment.date!);
                      final formattedDate = DateFormat.yMd().format(dateTime);

                      print('Comment is: $comment');
                      return ListTile(
                          leading: const Icon(Icons.comment),
                          title: Text(comment.body!),
                          subtitle: Text(comment.commenterName ?? 'Unknown'),
                          trailing: Text(formattedDate));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
