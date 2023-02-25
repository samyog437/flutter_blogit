import 'package:blogit/model/blog.dart';
import 'package:blogit/repository/blog_respository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<Blog>> _userblogs;

  // @override
  // void initState() {
  //   super.initState();
  //   _userblogs = BlogRepositoryImpl().getAllUserBlog();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: const NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg'),
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128,
                ),
              ),
            ),
          ),
          const Text(
            'John Doe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'johndoe@email.com',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'My Blogs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
