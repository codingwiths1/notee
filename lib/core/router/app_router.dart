import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notee/features/note/presentation/pages/create_note_page.dart';
import 'package:notee/features/note/presentation/pages/edit_note_page.dart';
import 'package:notee/features/note/presentation/pages/home_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: CreateNoteRoute.page),
    AutoRoute(page: EditNoteRoute.page),
  ];
}
