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
import 'package:notee/features/note/presentation/note_bloc/note_cubit.dart';
import 'package:notee/features/note/presentation/note_bloc/note_state.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NoteCubit>().updateloaders(loadingnotes: true);
    context.read<NoteCubit>().fetchnotes();
    super.initState();
  }

  Future<void> refresh() {
    context.read<NoteCubit>().updateloaders(loadingnotes: true);
    return context.read<NoteCubit>().fetchnotes(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: CupertinoNavigationBar(
            transitionBetweenRoutes: true,
            border: Border.all(color: AppColor.transparant),
            leading: Text(
              "Keep Note",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => refresh(),

            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: state.loadingnotes
                  ? Padding(
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
                            child: CircularProgressIndicator(
                              color: AppColor.blue,
                            ),
                          ),
                        ),
                      ),
                    )
                  : state.notelist.isEmpty
                  ? SizedBox(
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
                    )
                  : Padding(
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.view_agenda_rounded,
                                        color: AppColor.grey700,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: AppColor.transparant,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                                  state.notelist[index]["title"] ?? "";
                              final String noteText =
                                  state.notelist[index]["note"] ?? "";
                              final int id = state.notelist[index]["id"];
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
                            itemCount: state.notelist.length,
                          ),
                          10.toVert,
                          Center(
                            child: !state.loadmore
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: AppColor.blue,
                                      foregroundColor: AppColor.white,
                                    ),
                                    onPressed: () =>
                                        context.read<NoteCubit>().loadmore(),
                                    child: const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      size: 40,
                                    ),
                                  )
                                : SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColor.blue,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
            ),
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
