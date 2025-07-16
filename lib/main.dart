import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notee/app_widget.dart';
import 'package:notee/core/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColor.transparant),
  );
  runApp(const AppWidget());
}
