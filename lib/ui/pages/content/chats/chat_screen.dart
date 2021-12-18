import 'package:app_majpr_new/domain/models/chat_model.dart';
import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/chat_management.dart';
import 'package:app_majpr_new/ui/pages/chat/chat_page.dart';
import 'package:app_majpr_new/ui/pages/content/chats/widgets/chat_card.dart';
import 'package:app_majpr_new/ui/pages/content/chats/widgets/select_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMessages extends StatefulWidget {
  const UserMessages({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<UserMessages> {
  late AuthenticationController controller;
  late final ChatManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatsStream;

  @override
  void initState() {
    super.initState();
    manager = ChatManager();
    controller = Get.find<AuthenticationController>();
    chatsStream = manager.getChatList(controller.userActive!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: chatsStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final items = manager.extractChats(snapshot.data!);
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                ChatModel chat = items[index];
                UserModel user =
                    chat.getTargetUser(controller.userActive!.email);
                return ChatCard(
                  pictureUrl: user.avatarLink,
                  name: user.userName,
                  message: chat.lastMessage.message,
                  time: '',
                  onTap: () {
                    print('${chat.userA}');
                    print('${chat.userB}');
                    // Get.to(
                    //   () => ChatPage(
                    //       chat: chat,
                    //       localUser: chat.userA,
                    //       remoteUser: chat.userB),
                    // );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Something went wrong: ${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => SelectUser());
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
