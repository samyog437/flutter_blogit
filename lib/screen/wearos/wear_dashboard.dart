import 'package:blogit/model/blog.dart';
import 'package:blogit/repository/blog_respository.dart';
import 'package:blogit/screen/blogdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wear/wear.dart';

class WearDashboardScreen extends StatefulWidget {
  const WearDashboardScreen({super.key});

  static const String route = "wearDashboardScreen";

  @override
  State<WearDashboardScreen> createState() => _WearDashboardScreenState();
}

class _WearDashboardScreenState extends State<WearDashboardScreen> {
  late Future<List<Blog>> _blogs;

  @override
  void initState() {
    super.initState();
    _blogs = BlogRepositoryImpl().getAllBlog();
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: ((context, mode, child) {
            return Scaffold(
              body: Container(
                color: const Color(0xFFad5389),
                child: FutureBuilder(
                  future: _blogs,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Blog>> snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    'Blogs',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Blog blog = snapshot.data![index];

                                    int wordCount = 20;
                                    List<String> words =
                                        blog.content!.split(" ");
                                    String limitedContent =
                                        words.take(wordCount).join(" ");
                                    if (words.length > wordCount) {
                                      limitedContent += "...";
                                    }

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, BlogDetailScreen.route,
                                                arguments: blog);
                                          },
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: Text(
                                              blog.title!,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          subtitle: Text(
                                            limitedContent,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                          // onTap: () {},
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
          }),
        );
      },
    );
  }
}
