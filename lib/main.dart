import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notee/app_widget.dart';
import 'package:notee/core/di/di.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/note/view_model/repo/note_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  /// WIDGET INITIALIATION
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColor.transparant),
  );

  /// SUPABASE INITIALIATION
  await Supabase.initialize(
    url: "https://wdkoctqlkmvunmurwaam.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indka29jdHFsa212dW5tdXJ3YWFtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI2NzQyMzcsImV4cCI6MjA2ODI1MDIzN30.DQ6PSfwN9SwJPatHvYKNLmrlC7iSulfMMHPZGbPNYzc",
  );

  /// GET IT DEPENDENCIES
  configureDependencies();

  /// INIT AUTH
  getIt<NoteRepo>().initAuth();

  /// RUN APP
  runApp(const AppWidget());
}
