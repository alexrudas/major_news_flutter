import 'package:app_majpr_new/domain/models/chat_model.dart';
import 'package:app_majpr_new/domain/models/message.dart';
import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/chat_management.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/ui.dart';
import 'package:app_majpr_new/ui/pages/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  final ChatModel? chat;
  final UserModel? localUser, remoteUser;
  late final ChatManager manager;

  ChatPage({Key? key, this.chat, this.localUser, this.remoteUser})
      : super(key: key) {
    manager = ChatManager();
  }

  // Dependency injection: State management controller
  late final AuthenticationController controller = Get.find();
  late final UIController uiController = Get.find();

  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    UserModel? currentUser = controller.userActive;
    print('ChatPage $localUser $remoteUser');
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          // Fetching state value, with reactivity using Obx
          child: FutureBuilder<ChatModel>(
            future: _loadChatRecord(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ChatModel loadedChat = snapshot.data!;
                return ChatView(
                  chatReference: loadedChat.reference,
                  manager: manager,
                  localEmail: currentUser!.email,
                  updateChat: (message) async {
                    loadedChat.lastMessage = message;
                    await manager.updateChat(loadedChat);
                  },
                  onSend: (String message) async {
                    ChatMessage lastMessage = ChatMessage(
                        message: message, sender: currentUser.email);
                    loadedChat.lastMessage = lastMessage;
                    if (loadedChat.reference != null) {
                      loadedChat.lastMessage = lastMessage;
                      await manager.sendMessage(loadedChat);
                    } else {
                      return await manager.createChat(loadedChat);
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Future<ChatModel> _loadChatRecord() async {
    late ChatModel currentChat;
    if (chat != null) {
      currentChat = chat!;
    } else {
      ChatModel? retrievedChat =
          await manager.checkIfChatExist(localUser!.email, remoteUser!.email);
      currentChat = retrievedChat ??
          ChatModel(
            userA: localUser!,
            userB: remoteUser!,
            lastMessage: ChatMessage(message: '', sender: ''),
          );
    }
    return currentChat;
  }
}
