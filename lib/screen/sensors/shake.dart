import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShakeDetectorScreen extends StatefulWidget {
  const ShakeDetectorScreen({super.key});

  @override
  State<ShakeDetectorScreen> createState() => _ShakeDetectorScreenState();
}

class _ShakeDetectorScreenState extends State<ShakeDetectorScreen> {
  bool _shakeDetected = false;

  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    _streamSubscription.add(accelerometerEvents!.listen((event) {
      if (event.x.abs() > 15 || event.y.abs() > 15 || event.z.abs() > 15) {
        setState(() {
          _shakeDetected = true;
        });
      }
    }));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShakeDetectorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_shakeDetected == true) {
      Navigator.of(context).pop();
      _shakeDetected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogit'),
      ),
      body: const Center(
        child: Text('Shake your device to go back'),
      ),
    );
  }
}
