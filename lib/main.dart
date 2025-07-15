import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notee/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const AppWidget());
}
