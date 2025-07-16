import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notee/core/component/note_card.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/router/app_router.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notee/features/note/presentation/bloc/app_cubit.dart';
import 'package:notee/features/note/presentation/bloc/app_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: CupertinoNavigationBar(
            border: Border.all(color: AppColor.transparant),
            leading: Text(
              "Keep Note",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: Supabase.instance.client
                .from("notes")
                .stream(primaryKey: ["id"]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) => Container(
                      height: 70,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.secondaryColor,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(color: AppColor.blue),
                      ),
                    ),
                  ),
                );
              } else {
                List<Map<String, dynamic>> notes = snapshot.data ?? [];

                return notes.isEmpty
                    ? Center(
                        child: Image.asset(
                          "assets/images/empty-wishlist-illustration-download-in-svg-png-gif-file-formats--online-shop-store-state-pack-sign-symbols-illustrations-11838276 (1) (1) (1) (1).png",
                          fit: BoxFit.contain,
                          color: AppColor.black,
                          height: 250,
                          width: 250,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              30.toVert,
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Search note...",
                                        prefixIcon: Icon(
                                          Iconsax.search_normal,
                                          color: AppColor.black,
                                        ),
                                        suffixIcon: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.view_agenda_rounded,
                                            color: AppColor.grey700,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColor.transparant,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColor.transparant,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: AppColor.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              50.toVert,
                              MasonryGridView.builder(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),

                                itemBuilder: (context, index) {
                                  final String titleText =
                                      notes[index]["title"] ?? "";
                                  final String noteText =
                                      notes[index]["note"] ?? "";
                                  final int id = notes[index]["id"];
                                  return InkWell(
                                    onTap: () => context.router.push(
                                      EditNoteRoute(
                                        id: id,
                                        titleText: titleText,
                                        noteText: noteText,
                                      ),
                                    ),
                                    child: NoteCard(
                                      titleText: titleText,
                                      noteText: noteText,
                                    ),
                                  );
                                },
                                itemCount: notes.length,
                              ),
                            ],
                          ),
                        ),
                      );
              }
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
      },
    );
  }
}
