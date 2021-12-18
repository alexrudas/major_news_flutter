class ProfileUserModel {
  String uid;
  String? id;
  String userName;
  String message;
  String avatarLink;
  String date;

  ProfileUserModel(
      // constructor del modelo
      {
    required this.uid,
    this.id,
    required this.userName,
    required this.message,
    required this.avatarLink,
    required this.date,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> map) {
    final data = map["data"];
    return ProfileUserModel(
        uid: data['uid'],
        id: data['id'],
        userName: data['userName'],
        message: data['message'],
        avatarLink: data['avatarLink'],
        date: data['date']);
    //dbRef: map['ref']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "id": id,
        "userName": userName,
        "message": message,
        "avatarLink": avatarLink,
        "date": date,
      };
}
