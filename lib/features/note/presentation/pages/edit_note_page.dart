import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notee/app_widget.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/note/presentation/note_bloc/note_cubit.dart';
import 'package:notee/features/note/presentation/note_bloc/note_state.dart';

@RoutePage()
class EditNotePage extends StatelessWidget {
  const EditNotePage({
    super.key,
    required this.titleText,
    required this.noteText,
    required this.id,
  });
  final String titleText;
  final String noteText;
  final int id;

  // @override
  @override
  Widget build(BuildContext context) {
    final TextEditingController title = TextEditingController(text: titleText);
    final TextEditingController note = TextEditingController(text: noteText);
    final NoteCubit contxt = context.read<NoteCubit>();

    return Scaffold(
      appBar: CupertinoNavigationBar(
        trailing: IconButton(
          onPressed: () async {
            contxt.deletenote(id: id);
            appRouter.navigatorKey.currentContext!.router.back();
          },
          icon: BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              return state.delete
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: AppColor.blue),
                    )
                  : Icon(Iconsax.trash, size: 27, color: AppColor.red);
            },
          ),
        ),
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
      floatingActionButton: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColor.blue,
            foregroundColor: AppColor.white,
            onPressed: () async {
              if (title.text.trim().isNotEmpty || note.text.trim().isNotEmpty) {
                contxt.editnote(title: title.text, note: note.text, id: id);

                appRouter.navigatorKey.currentContext!.router.back();
              }
            },
            child: state.loading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: AppColor.white),
                  )
                : const Icon(Icons.done),
          );
        },
      ),
    );
  }
}
