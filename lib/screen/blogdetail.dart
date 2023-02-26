import 'package:blogit/app/constants.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key});

  static const String route = "blogDetailScreen";

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  late Blog blog;

  @override
  void didChangeDependencies() {
    blog = ModalRoute.of(context)!.settings.arguments as Blog;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // blog.view++;
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Image.network(
                      Constant.blogImageURL + blog.image!,
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    blog.title!,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    blog.user?.username ?? 'Unknown',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    blog.content!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
