import 'package:blogit/app/routes.dart';
import 'package:blogit/helper/objectbox.dart';
import 'package:blogit/state/objectbox_state.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  runApp(
    const MyApp(),
  );
}
