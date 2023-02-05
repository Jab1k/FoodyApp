import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/chat_controller.dart';
import '../../components/custom_textform.dart';
import 'messagepage.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final TextEditingController searchUser = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>()
        ..getUserList()
        ..getChatsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<ChatController>();
    final state = context.watch<ChatController>();
    return Scaffold(
      backgroundColor: Color(0xffF4F6F9),
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child:
                        CustomTextFrom(controller: searchUser, label: "Users")),
                IconButton(
                    onPressed: () {
                      event.changeAddUser();
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            state.addUser
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              event.createChat(index, (id) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MessagePage(
                                          docId: id,
                                          user: state.users[index],
                                        )));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  state.users[index].avatar == null
                                      ? const SizedBox.shrink()
                                      : ClipOval(
                                          child: Image.network(
                                            state.users[index].avatar ?? "",
                                            height: 62,
                                            width: 62,
                                          ),
                                        ),
                                  Text(state.users[index].name ?? "")
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.chats.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MessagePage(
                                            docId:
                                                state.listOfDocIdChats[index],
                                            user: state.chats[index].resender,
                                          )));
                            },
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  state.chats[index].resender.avatar == null
                                      ? const SizedBox.shrink()
                                      : ClipOval(
                                          child: Image.network(
                                            state.chats[index].resender
                                                    .avatar ??
                                                "",
                                            height: 62,
                                            width: 62,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  24.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          state.chats[index].resender.name ??
                                              "",
                                          style: TextStyle(fontSize: 18)),
                                      state.chats[index].userStatus
                                          ? Text(
                                              'Online',
                                              style: TextStyle(
                                                  color: Colors.lightGreen,
                                                  fontSize: 15),
                                            )
                                          : Text(
                                              'Offline',
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 15),
                                            )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
            100.horizontalSpace
          ],
        ),
      ),
    );
  }
}
