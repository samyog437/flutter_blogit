import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:blogit/screen/bottom_screen/dashboard.dart';
import 'package:blogit/screen/loginscreen.dart';
import 'package:blogit/screen/registerscreen.dart';
import 'package:blogit/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
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
}
