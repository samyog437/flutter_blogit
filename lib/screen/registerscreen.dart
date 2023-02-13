import 'dart:io';

import 'package:blogit/model/user.dart';
import 'package:blogit/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'testuser');
  final _emailController = TextEditingController(text: 'test@email.com');
  final _passwordController = TextEditingController(text: 'password');

  _saveUser() async {
    User user = User(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    int status = await UserRepositoryImpl().addUser(user);
    _showMessage(status);
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {}

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text('Registered Successfully'),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text('Error to add user'),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFad5389),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Username',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   child: const Text(
                      //     'Confirm Password',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       hintText: 'Confirm Password',
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       filled: true,
                      //       fillColor: Colors.white),
                      // ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                    _saveUser();
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginScreen');
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
