import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/home/bloc/app_cubit.dart';
import 'package:notee/features/home/bloc/app_state.dart';

@RoutePage()
class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, this.index});
  final int? index;
  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController note = TextEditingController();
  @override
  void initState() {
    final String titleText =
        context.read<AppCubit>().state.noteList[widget.index!]["TITLE"] ?? "";
    title.text = titleText.trim();

    final String noteText =
        context.read<AppCubit>().state.noteList[widget.index!]["NOTE"] ?? "";
    note.text = noteText.trim();

    title.addListener(() {
      if (title.text.trim().isNotEmpty) {
        context.read<AppCubit>().updateState(isTrue: true);
      } else {
        context.read<AppCubit>().updateState(isTrue: false);
      }
    });
    note.addListener(() {
      if (note.text.trim().isNotEmpty) {
        context.read<AppCubit>().updateState(isTrue: true);
      } else {
        context.read<AppCubit>().updateState(isTrue: false);
      }
    });
    super.initState();
  }

  @override
  dispose() {
    title.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: state.isTrue == true
                ? AppColor.blue
                : AppColor.grey400,
            foregroundColor: AppColor.white,
            onPressed: () {
              if (title.text.trim().isNotEmpty || note.text.trim().isNotEmpty) {
                context.read<AppCubit>().editNote(
                  index: widget.index!,
                  updatedNotes: {
                    "TITLE": title.text.trim(),
                    "NOTE": note.text.trim(),
                  },
                );
                context.router.back();
              }
            },
            child: const Icon(Icons.done),
          );
        },
      ),
    );
  }
}
