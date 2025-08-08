import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/core/di/di.dart';
import 'package:notee/core/pagination/custom_pagination.dart';
import 'package:notee/features/note/model/note_model.dart';
import 'package:notee/features/note/repo/note_repo.dart';

class NoteCubit extends Cubit<CustomPagination<NoteModel>> {
  NoteCubit()
    : super(
        CustomPagination(
          fetchData: (offset, limit) async {
            return await getIt<NoteRepo>().fetchNotes(offset, limit);
          },
        ),
      );

  // /// LOADING VARIABLES
  // void updateloaders({
  //   bool? loading,
  //   bool? delete,
  //   bool? loadingnotes,
  //   bool? loadmore,
  // }) {
  //   emit(
  //     state.copyWith(
  //       loading: loading,
  //       delete: delete,
  //       loadingnotes: loadingnotes,
  //       loadmore: loadmore,
  //     ),
  //   );
  // }

  // /// CREATE NEW NOTES
  // Future<void> creatnewnote({
  //   required String title,
  //   required String note,
  // }) async {
  //   updateloaders(loading: true);
  //   await Supabase.instance.client.from("notes").insert({
  //     "title": title.trim(),
  //     "note": note.trim(),
  //     "user_id": currentuser!.id,
  //   });
  //   updateloaders(loading: false);
  // }

  // /// EDIT NOTE
  // Future<void> editnote({
  //   required String title,
  //   required String note,
  //   required int id,
  // }) async {
  //   await Supabase.instance.client
  //       .from("notes")
  //       .update({"title": title.trim(), "note": note.trim()})
  //       .eq("user_id", currentuser!.id)
  //       .eq("id", id);
  // }

  // /// DELETE NOTE
  // Future<void> deletenote({required int id}) async {
  //   updateloaders(loading: true);

  //   await Supabase.instance.client
  //       .from("notes")
  //       .delete()
  //       .eq("id", id)
  //       .eq("user_id", currentuser!.id);
  //   updateloaders(loading: false);
  // }
}
