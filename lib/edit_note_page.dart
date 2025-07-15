import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/home/bloc/home_cubit.dart';
import 'package:notee/features/home/bloc/home_state.dart';

@RoutePage()
class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController note = TextEditingController();
  @override
  void initState() {
    final String titleText = context.read<HomeCubit>().state.titleText;
    final String noteText = context.read<HomeCubit>().state.noteText;

    title.text = titleText.trim();
    note.text = noteText.trim();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.read<HomeCubit>().updateText(
            title.text.trim(),
            note.text.trim(),
          );
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
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
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
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
                        hintStyle: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: AppColor.grey700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
