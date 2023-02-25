import 'dart:io';

import 'package:blogit/app/constants.dart';
import 'package:blogit/model/blog.dart';
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

  @override
  void didChangeDependencies() {
    blog = ModalRoute.of(context)!.settings.arguments as Blog;
    super.didChangeDependencies();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _editedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog'),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (_editedImage != null)
                  Image.file(_editedImage!)
                else
                  Image.network(Constant.blogImageURL + blog.image!),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  InkWell(
                                    child: const Text('Pick from gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const Divider(),
                                  InkWell(
                                    child: const Text('Take a photo'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black.withOpacity(0.5),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Editing blog "${blog.title}" by user ${blog.users?.usrId}'),
          ],
        ),
      ),
    );
  }
}
