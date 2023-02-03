import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Add a container to hold the blog post's title
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text("Blog Title", style: TextStyle(fontSize: 24)),
          ),
          // Add an image to display the blog post's cover image
          Image.network("https://via.placeholder.com/300x200"),
          // Add a container to hold the blog post's content
          Container(
            padding: const EdgeInsets.all(10),
            child:
                const Text("Blog Content...", style: TextStyle(fontSize: 18)),
          ),
          // Add a button to view more details of the blog post
          ElevatedButton(
            onPressed: () {
              // Navigate to the blog post's details page
            },
            child: const Text("View More"),
          )
        ],
      ),
    );
  }
}
