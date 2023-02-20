import 'package:blogit/model/blog.dart';
import 'package:blogit/repository/blog_respository.dart';
import 'package:blogit/screen/blogdetail.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search blogs...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: _blogs,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Blog>> snapshot) {
                  if (snapshot.hasData) {
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        double cardWidth = constraints.maxWidth < 750
                            ? constraints.maxWidth
                            : 750;
                        double titleFontSize =
                            constraints.maxWidth < 600 ? 20 : 28;
                        double contentFontSize =
                            constraints.maxWidth < 600 ? 16 : 22;

                        return Center(
                          child: SizedBox(
                            width: cardWidth,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                Blog blog = snapshot.data![index];

                                int wordCount = 20;
                                List<String> words = blog.content.split(" ");
                                String limitedContent =
                                    words.take(wordCount).join(" ");
                                if (words.length > wordCount) {
                                  limitedContent += "...";
                                }

                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Card(
                                    color: const Color(0xF5F5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, BlogDetailScreen.route,
                                            arguments: blog);
                                      },
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          blog.title,
                                          style: TextStyle(
                                            fontSize: titleFontSize,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                        limitedContent,
                                        style: TextStyle(
                                            fontSize: contentFontSize),
                                      ),
                                      leading: Icon(
                                        Icons.library_books,
                                        size: constraints.maxWidth < 600
                                            ? 30
                                            : 40,
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.visibility),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${blog.view.toString()} views',
                                          ),
                                        ],
                                      ),
                                      // onTap: () {},
                                    ),
                                  ),
                                );
                              },
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
          ),
        ],
      ),
    );
  }
}
