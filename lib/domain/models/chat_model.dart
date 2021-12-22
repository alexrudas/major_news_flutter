import 'package:app_majpr_new/domain/models/message.dart';
import 'package:app_majpr_new/domain/models/user_model.dart';

class ChatModel {
  UserModel userA, userB;
  ChatMessage lastMessage;
  String? reference;
  String? recordReference;

  ChatModel({
    required this.userA,
    required this.userB,
    required this.lastMessage,
    this.reference,
    this.recordReference,
  });

// Muestra aas tarjetas de los diferentes usurios en la  vista del chat
  UserModel getTargetUser(String email) {
    if (userA.email != email) {
      return userA;
    } else {
      return userB;
    }
  }

  factory ChatModel.fromJson(Map<String, dynamic> map) {
    final data = map['data'];
    return ChatModel(
      userA: UserModel.fromMap(data['userA']),
      userB: UserModel.fromMap(data['userB']),
      lastMessage: ChatMessage.fromJson(data['lastMessage']),
      reference: data['reference'],
      recordReference: data['ref'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userA": userA.toMap(),
      "userB": userB.toMap(),
      "users": {
        userA.email.replaceAll('.', ''): true,
        userB.email.replaceAll('.', ''): true
      },
      "lastMessage": lastMessage.toJson(),
      "reference": reference,
    };
  }
}
