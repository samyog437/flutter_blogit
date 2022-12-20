import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        // color: Color(0xFFad5389),
        // color: Colors.amber,
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        child: Align(
          alignment: const Alignment(0, -0.4),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    // fontFamily: 'Montserrat BlackItalic',
                  ),
                ),
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 256,
                  height: 256,
                  fit: BoxFit.cover,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    // style: ButtonStyle(
                    //   shape: MaterialStateProperty.all(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(18),
                    //     ),
                    //   ),
                    //   // backgroundColor: MaterialStateProperty.all(Colors.amber),
                    // ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    // style: ButtonStyle(
                    //   shape: MaterialStateProperty.all(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(18),
                    //     ),
                    //   ),
                    // ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
