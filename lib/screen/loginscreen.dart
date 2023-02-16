import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:blogit/app/snackbar.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/repository/user_repository.dart';
import 'package:blogit/screen/bottom_screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'testuser');
  final _passwordController = TextEditingController(text: 'password');

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
    _initializeNotifications();
  }

  _initializeNotifications() async {
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification for basic use',
        defaultColor: const Color(0xFFad5389),
        importance: NotificationImportance.Max,
        ledColor: Colors.green,
        channelShowBadge: true,
      ),
    ]);
  }

  _loginUser() async {
    final isLogin = await UserRepositoryImpl()
        .loginUser(_usernameController.text, _passwordController.text);
    if (isLogin) {
      final username = _usernameController.text;
      _goToAnotherPage();
      _showNotification(username);
    } else {
      _showMessage();
    }
  }

//   AwesomeNotifications().createNotification(
//   content: NotificationContent(
//     id: 1,
//     channelKey: 'basic_channel',
//     title: 'Welcome ${user.name}!',
//     body: 'You have logged in successfully.',
//     largeIcon: user.photoURL,
//   ),
//   actionButtons: [
//     NotificationActionButton(
//       key: 'LOGOUT',
//       label: 'Logout',
//       autoCancel: true,
//     ),
//   ],
// );

  _goToAnotherPage() {
    showSnackbar(context, 'Login Successful', Colors.green);
    Navigator.pushNamed(context, DashboardScreen.route);
  }

  _showMessage() {
    showSnackbar(context, 'Invalid username or password', Colors.red);
  }

  _showNotification(String username) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Login Successful',
          body: '$username has logged in'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isTablet = screenSize.width > 600;
    return Scaffold(
      body: Container(
        color: const Color(0xFFad5389),
        // color: Colors.amber,
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: Align(
            alignment: const Alignment(0, -0.4),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 256,
                    height: 256,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: isTablet
                        ? const EdgeInsets.all(40)
                        : const EdgeInsets.all(20),
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
                          key: const Key('txtUsername'),
                          controller: _usernameController,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.red),
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
                            'Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          key: const Key('txtPassword'),
                          controller: _passwordController,
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.red),
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
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      key: const ValueKey('btnLogin'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                        _loginUser();
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registerScreen');
                      },
                      child: const Text('Register'),
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
