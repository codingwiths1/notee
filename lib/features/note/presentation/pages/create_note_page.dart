import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/app_widget.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/note/presentation/bloc/app_cubit.dart';
import 'package:notee/features/note/presentation/bloc/app_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class CreateNotePage extends StatelessWidget {
  const CreateNotePage({super.key});

  @override
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
      floatingActionButton: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColor.blue,

            foregroundColor: AppColor.white,
            onPressed: () async {
              if (title.text.trim().isNotEmpty || note.text.trim().isNotEmpty) {
                // context.read<AppCubit>().updateText(
                //   notes: {"TITLE": title.text.trim(), "NOTE": note.text.trim()},
                // );
                log('TAPPED');
                await Supabase.instance.client.from("notes").insert({
                  "title": title.text.trim(),
                  "note": note.text.trim(),
                });
                appRouter.navigatorKey.currentContext!.router.back();
                log('SAVED');
              }
            },
            child: const Icon(Icons.done),
          );
        },
      ),
    );
  }
}
