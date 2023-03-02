import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:blogit/app/user_permission.dart';
import 'package:blogit/screen/blogdetail.dart';
import 'package:blogit/screen/bottom_screen/addBlogScreen.dart';
import 'package:blogit/screen/bottom_screen/dashboard.dart';
import 'package:blogit/screen/bottom_screen/homescreen.dart';
import 'package:blogit/screen/loginscreen.dart';
import 'package:blogit/screen/registerscreen.dart';
import 'package:blogit/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  // Grant permission to send notifications
  const MethodChannel('flutter_local_notifications')
      .setMockMethodCallHandler((MethodCall methodCall) async {});
  group('User test', () {
    testWidgets('Login User', (WidgetTester tester) async {
      await AwesomeNotifications().requestPermissionToSendNotifications();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/loginScreen': (context) => const LoginScreen(),
            DashboardScreen.route: (context) => const DashboardScreen(),
          },
        ),
      );
      await tester.pumpAndSettle();
      Finder txtUsername = find.byKey(const ValueKey('txtUsername'));
      await tester.enterText(txtUsername, 'testuser');
      Finder txtPassword = find.byKey(const ValueKey('txtPassword'));
      await tester.enterText(txtPassword, 'password');
      Finder btnLogin = find.byKey(const ValueKey('btnLogin'));
      await tester.tap(btnLogin);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Register User', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/loginScreen': (context) => const LoginScreen(),
            '/registerScreen': (context) => const RegisterScreen(),
          },
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('btnGoToRegister')));
      await tester.pumpAndSettle();

      Finder txtUsername = find.byKey(const ValueKey('txtUsername'));
      await tester.enterText(txtUsername, 'testuser4');
      Finder txtEmail = find.byKey(const ValueKey('txtEmail'));
      await tester.enterText(txtEmail, 'test4@email.com');
      Finder txtPassword = find.byKey(const ValueKey('txtPassword'));
      await tester.enterText(txtPassword, 'password');
      Finder btnRegister = find.byKey(const ValueKey('btnRegister'));
      await tester.tap(btnRegister);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Login'), findsOneWidget);
    });
  });

  testWidgets('getABlog', (WidgetTester tester) async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/loginScreen': (context) => const LoginScreen(),
          DashboardScreen.route: (context) => const DashboardScreen(),
          BlogDetailScreen.route: (context) => const BlogDetailScreen(),
        },
      ),
    );
    await tester.pumpAndSettle();
    Finder txtUsername = find.byKey(const ValueKey('txtUsername'));
    await tester.enterText(txtUsername, 'testuser');
    Finder txtPassword = find.byKey(const ValueKey('txtPassword'));
    await tester.enterText(txtPassword, 'password');
    Finder btnLogin = find.byKey(const ValueKey('btnLogin'));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('Dashboard'), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();
  });

  testWidgets('createBlog', (WidgetTester tester) async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
    await UserPermission.checkCameraPermission();
    // Build the app and wait for it to settle
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/loginScreen': (context) => const LoginScreen(),
          DashboardScreen.route: (context) => const DashboardScreen(),
          AddBlogScreen.route: (context) => const AddBlogScreen(),
        },
      ),
    );
    await tester.pumpAndSettle();

    // Log in as a test user
    final txtUsername = find.byKey(const ValueKey('txtUsername'));
    await tester.enterText(txtUsername, 'testuser');
    final txtPassword = find.byKey(const ValueKey('txtPassword'));
    await tester.enterText(txtPassword, 'password');
    final btnLogin = find.byKey(const ValueKey('btnLogin'));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('Dashboard'), findsOneWidget);
    await tester.pumpAndSettle();
    // Navigate to the create blog screen
    Finder tabAdd = find.byIcon(Icons.add_circle_outline_outlined);
    await tester.tap(tabAdd);
    await tester.pumpAndSettle();
    Finder txtTitle = find.byKey(const ValueKey('txtTitle'));
    await tester.enterText(txtTitle, 'Test Blog Title');
    Finder txtContent = find.byKey(const ValueKey('txtContent'));
    await tester.enterText(txtContent, 'Test Blog Content');
    Finder btnSubmit = find.byKey(const ValueKey('btnAddBlog'));
    await tester.tap(btnSubmit);
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.widgetWithText(SnackBar, 'Blog Added Successfully!'),
        findsOneWidget);
  });

  testWidgets('Should Delete a Blog', (WidgetTester tester) async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
    await UserPermission.checkCameraPermission();
    // Build the app and wait for it to settle
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/loginScreen': (context) => const LoginScreen(),
          DashboardScreen.route: (context) => const DashboardScreen(),
          AddBlogScreen.route: (context) => const AddBlogScreen(),
        },
      ),
    );
    await tester.pumpAndSettle();

    // Log in as a test user
    final txtUsername = find.byKey(const ValueKey('txtUsername'));
    await tester.enterText(txtUsername, 'testuser');
    final txtPassword = find.byKey(const ValueKey('txtPassword'));
    await tester.enterText(txtPassword, 'password');
    final btnLogin = find.byKey(const ValueKey('btnLogin'));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('Dashboard'), findsOneWidget);
    await tester.pumpAndSettle();

    Finder tabDelete = find.byIcon(Icons.person);
    await tester.tap(tabDelete);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ListTile).first);
    Finder btnSubmit = find.byKey(const ValueKey('btnDelete_0'));
    await tester.tap(btnSubmit);
    await tester.pumpAndSettle(Duration(seconds: 1));
    Finder btnConfirm = find.byKey(const ValueKey('Confirm'));
    await tester.tap(btnConfirm);
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.widgetWithText(SnackBar, 'Blog Deleted Successfully!'),
        findsOneWidget);
  });
}
