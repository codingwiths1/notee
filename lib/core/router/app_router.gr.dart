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
  EditNoteRoute({Key? key, int? index, List<PageRouteInfo>? children})
    : super(
        EditNoteRoute.name,
        args: EditNoteRouteArgs(key: key, index: index),
        initialChildren: children,
      );

  static const String name = 'EditNoteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditNoteRouteArgs>(
        orElse: () => const EditNoteRouteArgs(),
      );
      return EditNotePage(key: args.key, index: args.index);
    },
  );
}

class EditNoteRouteArgs {
  const EditNoteRouteArgs({this.key, this.index});

  final Key? key;

  final int? index;

  @override
  String toString() {
    return 'EditNoteRouteArgs{key: $key, index: $index}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditNoteRouteArgs) return false;
    return key == other.key && index == other.index;
  }

  @override
  int get hashCode => key.hashCode ^ index.hashCode;
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
