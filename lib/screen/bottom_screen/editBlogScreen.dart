import 'dart:io';

import 'package:blogit/app/constants.dart';
import 'package:blogit/app/snackbar.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/repository/blog_respository.dart';
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

  Future<void> _editedBlog() async {
    Blog updatedBlog = Blog(
      title: _titleController.text,
      content: _contentController.text,
    );
    print('Updating blog: $updatedBlog');
    print("Before calling editBlog method");
    int status = await BlogRepositoryImpl()
        .editBlog(_editedImage, updatedBlog, blog, Constant.userId);
    print('Sent Blog: ${updatedBlog}');
    print('Sent ID : ${blog.user?.usrId.toString().trim()}');
    print("After calling editBlog method, result: $status");
    print('Status: $status');
    _showMessage(status);
  }

  _showMessage(int status) {
    print('Status: $status');
    if (status > 0) {
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
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _editedImage != null
                        ? Image.file(_editedImage!)
                        : Image.network(
                            Constant.blogImageURL + (blog.image ?? '')),
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
                      ElevatedButton.icon(
                        onPressed: () {
                          _browseImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.image),
                        label: const Text('Gallery'),
                      ),
                    ],
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
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _editedBlog();
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFad5389)),
                ),
                child: const Text(
                  'Edit Blog',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
