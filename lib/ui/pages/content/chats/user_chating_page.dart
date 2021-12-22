import 'package:app_majpr_new/domain/models/chat_model.dart';
import 'package:app_majpr_new/domain/models/message.dart';
import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/chat_management.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/ui.dart';
import 'package:app_majpr_new/ui/pages/authentication/user_update/user_update.dart';
import 'package:app_majpr_new/ui/pages/content/chats/widgets/chat_screen_widget.dart';
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
    // print(
    //     'ChatPage ${currentUser!.email.toString()} ${remoteUser!.email.toString()}');
    return Scaffold(
      appBar: AppBar(title: Text(remoteUser!.userName), actions: <Widget>[
        // Widgets que  realizan acciones
        IconButton(
          key: Key("profile"),
          icon: Icon(Icons.account_circle),
          color: Colors.white,
          //size: 20
          onPressed: () {
            Get.to(() => UserUpdate());
          },
        ),

        IconButton(
          key: Key("darkBtn"),
          icon: Icon(Icons.brightness_4_rounded),
          color: Colors.white,
          onPressed: () {
            Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
          },
        ),
        // El botón Logout presenta problemas, luego de salir no se puede Iniciar Sesión
        // IconButton(
        //   key: Key("logoutBtn"),
        //   icon: Icon(Icons.logout),
        //   color: Colors.white,
        //   onPressed: () {
        //     AuthenticationController authenticationController = Get.find();
        //     authenticationController
        //         .logout(); // controla que el logout se haya efectuado
        //     Get.to(() => InitialPresentation());
        // },
        //),
      ]),
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
              return const Center(child: Text('spining'));
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
      ChatModel? retrievedChat = await manager.checkIfChatExist(
          localUser!.email, remoteUser!.email, localUser!, remoteUser!);
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
