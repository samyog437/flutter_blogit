import 'package:blogit/app/constants.dart';
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

  final _searchController = TextEditingController();
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _blogs = BlogRepositoryImpl().getAllBlog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double cardWidth =
            constraints.maxWidth < 750 ? constraints.maxWidth : 750;
        double titleFontSize = constraints.maxWidth < 600 ? 20 : 28;
        double contentFontSize = constraints.maxWidth < 600 ? 16 : 22;
        double viewFontSize = constraints.maxWidth < 600 ? 14 : 18;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Container(
                width: constraints.maxWidth < 600 ? double.infinity : cardWidth,
                height: constraints.maxHeight < 600 ? 40 : 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search blogs...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                      style: TextStyle(fontSize: contentFontSize),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              floating: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: FutureBuilder(
                future: _blogs,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Blog blog = snapshot.data![index];
                          if (_searchText.isEmpty ||
                              blog.title!
                                  .toLowerCase()
                                  .contains(_searchText.toLowerCase())) {
                            int wordCount = 10;
                            List<String> words = blog.content!.split(" ");
                            String limitedContent =
                                words.take(wordCount).join(" ");
                            if (words.length > wordCount) {
                              limitedContent += "...";
                            }

                            return Center(
                              child: Container(
                                width: cardWidth,
                                padding: const EdgeInsets.all(10),
                                child: Card(
                                  color: const Color(0xF5F5F5F5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      Blog? blog = await BlogRepositoryImpl()
                                          .getABlog(
                                              snapshot.data![index].blogId);
                                      if (blog != null) {
                                        Future.microtask(() {
                                          Navigator.pushNamed(
                                              context, BlogDetailScreen.route,
                                              arguments: blog);
                                        });
                                      }
                                    },
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        blog.title!,
                                        style: TextStyle(
                                          fontSize: titleFontSize,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      limitedContent,
                                      style:
                                          TextStyle(fontSize: contentFontSize),
                                    ),
                                    leading: blog.image != null
                                        ? Image.network(
                                            Constant.blogImageURL + blog.image!)
                                        : Icon(Icons.library_books,
                                            size: constraints.maxWidth < 600
                                                ? 30
                                                : 40),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.visibility),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${blog.view.toString()} views',
                                          style:
                                              TextStyle(fontSize: viewFontSize),
                                        ),
                                      ],
                                    ),
                                    // onTap: () {},
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                        childCount: snapshot.data!.length,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text('An error occurred: ${snapshot.error}'),
                      ),
                    );
                  } else {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
