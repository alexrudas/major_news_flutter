import 'package:app_majpr_new/data/repositories_data/chat_repo_data/firestore_database_chat.dart';
import 'package:app_majpr_new/data/repositories_data/chat_repo_data/realtime_database.dart';
import 'package:app_majpr_new/domain/models/chat_model.dart';
import 'package:app_majpr_new/domain/models/message.dart';
import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatManager {
  FirestoreChat firestore = FirestoreChat();
  RealTimeChat realtime = RealTimeChat();

  // Chats

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList(String localEmail) {
    return firestore.getChatRecords(localEmail);
  }

  Future<ChatModel?> checkIfChatExist(
      String emailA, String emailB, UserModel local, UserModel remote) async {
    print("ChatManager checkIfChatExist");
    final chat = await firestore.checkIfRecordExist(emailA, emailB);
    return chat != null
        ? ChatModel.fromJson(chat)
        : ChatModel(
            userA: local,
            userB: remote,
            lastMessage: ChatMessage(message: '', sender: ''),
          );
  }

  Future<String> createChat(ChatModel chat) async {
    final chatReference =
        await realtime.createChat(message: chat.lastMessage.toJson());
    chat.reference = chatReference;
    await firestore.createChatRecord(chat: chat.toJson());
    return chatReference;
  }

  Future<void> updateChat(ChatModel chatModel) async {
    await firestore.updateChatRecord(
        recordPath: chatModel.recordReference!, chat: chatModel.toJson());
  }

  List<ChatModel> extractChats(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final chatsData = firestore.extractDocs(snapshot);
    return _extractChatInstances(chatsData);
  }

  List<ChatModel> _extractChatInstances(List<Map<String, dynamic>> data) {
    List<ChatModel> chats = [];
    for (var chat in data) {
      chats.add(
        ChatModel.fromJson(chat),
      );
    }
    return chats;
  }

  // Messages

  Stream<Event> getChatStream({required String chatReference}) {
    return realtime.connectChat(chatPath: chatReference);
  }

  Future<void> sendMessage(ChatModel chatModel) async {
    await realtime.sendMessage(
        chatPath: chatModel.reference!,
        message: chatModel.lastMessage.toJson());
    await updateChat(chatModel);
  }

  Future<void> deleteMessage(String chatReference, ChatMessage message) async {
    await realtime.deleteMessage(
        chatPath: chatReference, messagePath: message.reference!);
  }

  List<ChatMessage> extractMessages(DataSnapshot snapshot) {
    final chatsData = realtime.extractDocs(snapshot);
    return _extractMessagesInstances(chatsData);
  }

  List<ChatMessage> _extractMessagesInstances(List<Map<String, dynamic>> data) {
    List<ChatMessage> chats = [];
    for (var chat in data) {
      chats.add(
        ChatMessage.fromJson(chat),
      );
    }
    return chats;
  }
}
