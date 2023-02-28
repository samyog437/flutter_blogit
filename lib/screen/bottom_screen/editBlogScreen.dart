import 'dart:io';

import 'package:blogit/app/constants.dart';
import 'package:blogit/app/snackbar.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/repository/blog_respository.dart';
import 'package:blogit/screen/bottom_screen/profilescreen.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class EditBlogScreen extends StatefulWidget {
  const EditBlogScreen({super.key});

  static const String route = "editScreen";

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  late Blog blog;
  File? _editedImage;

  late TextEditingController _titleController;
  late TextEditingController _contentController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    _contentController = TextEditingController(text: '');
  }

  @override
  void didChangeDependencies() {
    blog = ModalRoute.of(context)!.settings.arguments as Blog;
    _titleController = TextEditingController(text: blog.title ?? '');
    _contentController = TextEditingController(text: blog.content ?? '');
    super.didChangeDependencies();
  }

  _editedBlog() async {
    Blog updatedBlog = Blog(
      title: _titleController.text,
      content: _contentController.text,
    );
    int status = await BlogRepositoryImpl()
        .editBlog(_editedImage, updatedBlog, blog, Constant.userId);
    _showMessage(status);
    Navigator.popAndPushNamed(context, ProfileScreen.route);
  }

  _showMessage(int status) {
    print('Status: $status');
    if (status > 0) {
      setState(() {
        _titleController.clear();
        _contentController.clear();
        _editedImage = null;
      });
      showSnackbar(context, 'Blog Added Successfully!', Colors.green);
    } else if (status == 0) {
      showSnackbar(context, 'Error Adding Blog', Colors.red);
    } else {
      showSnackbar(context, 'Error: $status', Colors.red);
    }
  }

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          print('Image path: ${image.path}');
          _editedImage = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _editedImage != null
                        ? Image.file(_editedImage!, fit: BoxFit.cover)
                        : (blog.image != null
                            ? Image.network(Constant.blogImageURL + blog.image!,
                                fit: BoxFit.cover)
                            : const Center(
                                child: Text(
                                  'Add an image',
                                  textAlign: TextAlign.center,
                                ),
                              )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _browseImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          _browseImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.image),
                        label: const Text('Gallery'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _contentController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some content';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final updatedBlog = await _editedBlog();
                        Navigator.pop(context, updatedBlog);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFad5389)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Edit Blog',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
