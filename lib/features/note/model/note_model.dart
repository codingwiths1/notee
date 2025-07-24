class NoteModel {
  final String title;
  final String note;
  final int id;

  NoteModel({required this.title, required this.note, required this.id});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json["title"] ?? "",
      note: json["note"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "note": note, "title": title};
  }
}
