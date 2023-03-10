import 'dart:io';
import 'package:blogit/app/snackbar.dart';
import 'package:blogit/app/user_permission.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/repository/blog_respository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  static const String route = "AddBlogScreen";

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  _addBlog() async {
    Blog blog = Blog(
      title: _titleController.text,
      content: _contentController.text,
    );

    int status = await BlogRepositoryImpl().createBlog(_img, blog);
    _showMessage(status);
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _showMessage(int status) {
    if (status > 0) {
      setState(() {
        _img = null;
        _titleController.clear();
        _contentController.clear();
      });
      showSnackbar(context, 'Blog Added Successfully!', Colors.green);
    } else {
      showSnackbar(context, 'Error Adding Blog', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double imgWidth =
                  constraints.maxWidth < 600 ? constraints.maxWidth : 500;
              double imgHeight =
                  constraints.maxHeight < 600 ? constraints.maxHeight : 300;
              double resWidth =
                  constraints.maxWidth < 600 ? constraints.maxHeight : 750;

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: imgWidth,
                      height: imgHeight,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: _img != null
                          ? Image.file(
                              _img!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : const Text(
                              'No image selected',
                              textAlign: TextAlign.center,
                            ),
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
                    const SizedBox(height: 20),
                    const Text(
                      'Add a Blog',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: resWidth,
                      child: Column(
                        children: [
                          TextFormField(
                            key: const Key('txtTitle'),
                            controller: _titleController,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              hintText: 'Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: const Key('txtContent'),
                            controller: _contentController,
                            maxLines: null,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              hintText: 'Content',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            key: const ValueKey('btnAddBlog'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _addBlog();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFad5389),
                              ),
                            ),
                            child: const Text(
                              'Add Blog',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
