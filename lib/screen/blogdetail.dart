import 'package:blogit/app/constants.dart';
import 'package:blogit/model/blog.dart';
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
  TextEditingController commentController = TextEditingController();

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    Constant.blogImageURL + blog.image!,
                    height: constraints.maxWidth * 0.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
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
                    blog.user?.username ?? 'Unknown',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: commentController,
                        maxLines: 5,
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
                        onPressed: () {},
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
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
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
