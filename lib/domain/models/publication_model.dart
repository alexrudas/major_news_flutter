class PublicationModel {
  String uid;
  String? section;
  String? date;
  String? title;
  String? message;
  String? userName;

  PublicationModel(
      // constructor del modelo
      {
    required this.uid,
    this.section,
    this.date,
    this.title,
    this.message,
    this.userName,
  }); // se crea el constructor del modelo

  factory PublicationModel.fromJson(Map<String, dynamic> map) {
    final data = map["data"];
    return PublicationModel(
        uid: data['uid'],
        section: data['section'],
        date: data['date'],
        title: data['title'],
        message: data['message'],
        userName: data['userName']);
    //dbRef: map['ref']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "section": section,
        "date": date,
        "title": title,
        "message": message,
        "userName": userName,
      };
}
