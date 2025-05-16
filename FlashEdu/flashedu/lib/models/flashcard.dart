class Flashcard {
  int? id;
  String frontText;
  String backText;
  int folderId;

  Flashcard({this.id, required this.frontText, required this.backText, required this.folderId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'front_text': frontText,
      'back_text': backText,
      'folder_id': folderId,
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'],
      frontText: map['front_text'],
      backText: map['back_text'],
      folderId: map['folder_id'],

    );
  }
}
