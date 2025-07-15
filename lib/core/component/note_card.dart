import 'package:flutter/material.dart';
import 'package:notee/core/extention/extention.dart';
import 'package:notee/core/theme/theme.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.titleText, required this.noteText});

  final String titleText;
  final String noteText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              titleText,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(overflow: TextOverflow.clip),
            ),
          ),
          10.toVert,
          Expanded(
            child: Text(
              noteText,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(overflow: TextOverflow.clip),
            ),
          ),
        ],
      ),
    );
  }
}
