import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/app_widget.dart';
import 'package:notee/core/di/di.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/pagination/custom_pagination.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/note/model/note_model.dart';
import 'package:notee/features/note/view_model/note_bloc/note_cubit.dart';
import 'package:notee/features/note/repo/note_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class CreateNotePage extends StatelessWidget {
  const CreateNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController title = TextEditingController();
    final TextEditingController note = TextEditingController();

    return Scaffold(
      appBar: CupertinoNavigationBar(
        transitionBetweenRoutes: true,
        automaticallyImplyLeading: true,
        border: Border.all(color: AppColor.transparant),
        previousPageTitle: "Back",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: title,
                    maxLines: null,
                    style: Theme.of(context).textTheme.headlineMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: AppColor.grey700),
                    ),
                  ),
                ),
              ],
            ),
            20.toVert,
            Expanded(
              child: TextField(
                controller: note,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note",
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: AppColor.grey700),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<NoteCubit, CustomPagination<NoteModel>>(
        builder: (context, state) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColor.blue,

            foregroundColor: AppColor.white,
            onPressed: () async {
              if (title.text.trim().isNotEmpty || note.text.trim().isNotEmpty) {
                final currentUserId =
                    getIt<SupabaseClient>().auth.currentUser?.id;

                if (currentUserId == null) {
                  log("No User Signed In");
                }
                await getIt<NoteRepo>().addNote(
                  newTitle: title.text,
                  newNote: note.text,
                );
                appRouter.navigatorKey.currentContext!.router.back();
              }
            },
            child: const Icon(Icons.done),
          );
        },
      ),
    );
  }
}
