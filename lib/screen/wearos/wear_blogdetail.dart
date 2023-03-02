import 'package:blogit/app/constants.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/model/comment.dart';
import 'package:blogit/repository/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class WearBlogDetailScreen extends StatefulWidget {
  const WearBlogDetailScreen({super.key});

  static const String route = "wearBlogDetail";

  @override
  State<WearBlogDetailScreen> createState() => _WearBlogDetailScreenState();
}

class _WearBlogDetailScreenState extends State<WearBlogDetailScreen> {
  late Blog blog;
  final _commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
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
                  const Center(
                    child: Text(
                      'Comments',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  blog.comments!.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: blog.comments!.length,
                          itemBuilder: (context, index) {
                            var comment = blog.comments![index];
                            return ListTile(
                              title: Text(comment.body!),
                              subtitle:
                                  Text(comment.commenterName ?? 'Unknown'),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No comments found'),
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
