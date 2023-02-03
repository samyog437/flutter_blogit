import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wear/wear.dart';

class WearDashboardScreen extends StatefulWidget {
  const WearDashboardScreen({super.key});

  static const String route = "wearDashboardScreen";

  @override
  State<WearDashboardScreen> createState() => _WearDashboardScreenState();
}

class _WearDashboardScreenState extends State<WearDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: ((context, mode, child) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Login'),
              ),
              body: Container(
                child: const Text('Dashboard'),
              ),
            );
          }),
        );
      },
    );
  }
}
