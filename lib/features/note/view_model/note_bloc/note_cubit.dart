import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notee/core/di/di.dart';
import 'package:notee/core/pagination/custom_pagination.dart';
import 'package:notee/features/note/view_model/note_bloc/note_state.dart';
import 'package:notee/features/note/repo/note_repo.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit()
    : super(
        NoteState(
          loadmore: false,
          pagingController: CustomPagination(
            fetchData: (offset, limit) async {
              return await getIt<NoteRepoIMpl>().fetchNotes(offset, limit);
            },
          ),
          loading: false,
          delete: false,
          loadingnotes: false,
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
