import 'package:blogit/model/blog.dart';
import 'package:blogit/repository/blog_respository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Blog>> _blogs;

  @override
  void initState() {
    super.initState();
    _blogs = BlogRepositoryImpl().getAllBlog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 238, 238, 238),
        child: FutureBuilder(
          future: _blogs,
          builder: (BuildContext context, AsyncSnapshot<List<Blog>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  Blog blog = snapshot.data![index];

                  int wordCount = 20;
                  List<String> words = blog.content.split(" ");
                  String limitedContent = words.take(wordCount).join(" ");
                  if (words.length > wordCount) {
                    limitedContent += "...";
                  }

                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            blog.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          limitedContent,
                          style: const TextStyle(fontSize: 16),
                        ),
                        leading: const Icon(
                          Icons.library_books,
                          size: 30,
                        ),
                        // onTap: () {},
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('An error occurred: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
