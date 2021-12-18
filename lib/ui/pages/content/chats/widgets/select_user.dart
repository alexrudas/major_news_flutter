import 'package:app_majpr_new/data/repositories_data/chat_repo_data/realtime_database.dart';
import 'package:app_majpr_new/domain/models/message.dart';
import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/ui/pages/chat/chat_page.dart';
import 'package:app_majpr_new/ui/pages/content/chats/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SelectUser> {
  AuthenticationController authenticationController = Get.find();
  getUser() async {
    return authenticationController.extractAllUser();
  }

  createChat(remoteUser, localUser, date) async {
    String reference = await realTimeChat.createChat(
        message: ChatMessage(message: '', sender: localUser.email).toJson());
    //print(reference);
  }

  RealTimeChat realTimeChat = Get.find();

  List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Center(child: Text('No hay usuarios'));
              } else {
                users = snapshot.data as List<UserModel>;
                DateFormat format = DateFormat('MMMM-dd-yyyy / hh:mm a');
                DateTime newDate = DateTime.now();
                String date = format.format(newDate);
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      //print(users[index]);
                      createChat(users[index],
                          authenticationController.userActive, date);
                      return ChatCard(
                        message: '',
                        name: users[index].userName,
                        onTap: () {
                          Get.back();
                          Get.to(() => ChatPage(
                                localUser: authenticationController.userActive,
                                remoteUser: users[index],
                              ));
                        },
                        pictureUrl: users[index].avatarLink,
                        time: date,
                      );
                    });
              }
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
