// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CreateNotePage]
class CreateNoteRoute extends PageRouteInfo<void> {
  const CreateNoteRoute({List<PageRouteInfo>? children})
    : super(CreateNoteRoute.name, initialChildren: children);

  static const String name = 'CreateNoteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateNotePage();
    },
  );
}

/// generated route for
/// [EditNotePage]
class EditNoteRoute extends PageRouteInfo<EditNoteRouteArgs> {
  EditNoteRoute({
    Key? key,
    required String titleText,
    required String noteText,
    required int id,
    List<PageRouteInfo>? children,
  }) : super(
         EditNoteRoute.name,
         args: EditNoteRouteArgs(
           key: key,
           titleText: titleText,
           noteText: noteText,
           id: id,
         ),
         initialChildren: children,
       );

  static const String name = 'EditNoteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditNoteRouteArgs>();
      return EditNotePage(
        key: args.key,
        titleText: args.titleText,
        noteText: args.noteText,
        id: args.id,
      );
    },
  );
}

class EditNoteRouteArgs {
  const EditNoteRouteArgs({
    this.key,
    required this.titleText,
    required this.noteText,
    required this.id,
  });

  final Key? key;

  final String titleText;

  final String noteText;

  final int id;

  @override
  String toString() {
    return 'EditNoteRouteArgs{key: $key, titleText: $titleText, noteText: $noteText, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditNoteRouteArgs) return false;
    return key == other.key &&
        titleText == other.titleText &&
        noteText == other.noteText &&
        id == other.id;
  }

  @override
  int get hashCode =>
      key.hashCode ^ titleText.hashCode ^ noteText.hashCode ^ id.hashCode;
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}
