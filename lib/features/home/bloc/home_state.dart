class HomeState {
  final String titleText;
  final String noteText;

  HomeState({required this.titleText, required this.noteText});
  HomeState copyWith({String? titleText, String? noteText}) {
    return HomeState(
      titleText: titleText ?? this.titleText,
      noteText: noteText ?? this.noteText,
    );
  }
}
