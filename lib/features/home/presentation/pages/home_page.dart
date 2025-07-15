import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notee/core/component/note_card.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/router/app_router.dart';
import 'package:notee/core/theme/theme.dart';
import 'package:notee/features/home/bloc/home_cubit.dart';
import 'package:notee/features/home/bloc/home_state.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
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
          body: SingleChildScrollView(
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => context.router.push(const EditNoteRoute()),
                        child: NoteCard(
                          titleText: state.titleText,
                          noteText: state.noteText,
                        ),
                      );
                    },
                    itemCount: 5,
                  ),
                ],
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
