import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:notee/core/router/app_router.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/note/model/note_model.dart';
import 'package:notee/features/note/view_model/note_bloc/note_cubit.dart';
import 'package:notee/features/note/view_model/note_bloc/note_state.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: const Text('Notes'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          final pagination = state.pagingController;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<NoteCubit>().state.pagingController.refresh();
            },
            child: PagedListView<int, NoteModel>(
              physics: const AlwaysScrollableScrollPhysics(),
              pagingController: pagination.pagingController,
              builderDelegate: PagedChildBuilderDelegate<NoteModel>(
                noItemsFoundIndicatorBuilder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset(
                      "assets/images/empty-wishlist-illustration-download-in-svg-png-gif-file-formats--online-shop-store-state-pack-sign-symbols-illustrations-11838276 (1) (1) (1) (1).png",
                      fit: BoxFit.contain,
                      color: AppColor.black,
                      height: 250,
                      width: 250,
                    ),
                  ),
                ),
                itemBuilder: (context, note, index) {
                  final String titleText = note.title;
                  final String noteText = note.note;
                  final int id = note.id;

                  return InkWell(
                    onTap: () => context.router.push(
                      EditNoteRoute(
                        id: id,
                        titleText: titleText,
                        noteText: noteText,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        tileColor: AppColor.grey700,

                        title: note.title.isNotEmpty
                            ? Text(
                                note.title,
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const SizedBox.shrink(),
                        subtitle: note.note.isNotEmpty
                            ? Text(
                                note.note,
                                style: TextStyle(color: AppColor.white),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColor.blue,
          onPressed: () => context.router.push(const CreateNoteRoute()),
          child: Icon(Icons.add, color: AppColor.white),
        ),
      ),
    );
  }
}
