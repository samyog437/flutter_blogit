import 'dart:io';
import 'package:blogit/app/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
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
      showSnackbar(context, 'Blog Added Successfully!', Colors.green);
    } else {
      showSnackbar(context, 'Error Adding Blog', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add a Blog',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                    color: Colors.white, backgroundColor: Colors.red),
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                    color: Colors.white, backgroundColor: Colors.red),
                hintText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFad5389)),
              ),
              child: const Text(
                'Add Blog',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }
}
