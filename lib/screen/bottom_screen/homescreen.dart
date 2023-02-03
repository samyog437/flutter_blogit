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
        body: FutureBuilder(
            future: _blogs,
            builder:
                (BuildContext context, AsyncSnapshot<List<Blog>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Blog blog = snapshot.data![index];
                    return ListTile(
                      title: Text(blog.title),
                      subtitle: Text(blog.content),
                      leading: const Icon(Icons.library_books),
                      // onTap: () {},
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
            }));
  }
}
