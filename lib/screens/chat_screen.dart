import 'package:chat_app/constants.dart';
import 'package:chat_app/custom_widgets/chat_bubble.dart';
import 'package:chat_app/custom_widgets/loading_widget.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static const String routeName = 'chat_screen';
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(55),
                child: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 50),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/scholar.png',
                            height: 60,
                          ),
                          const Text(
                            'Chat',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ]),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index],
                              )
                            : ChatBubbleSecondUser(
                                message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (data) {
                        onSubmit(data, email);
                      },
                      controller: controller,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send, color: kPrimaryColor),
                          onPressed: () {
                            onSubmit(controller.text, email);
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: kPrimaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return LoadingScreen();
          }
        });
  }

  void onSubmit(String data, String email) {
    messages.add(
      {'message': data, 'createdAt': DateTime.now(), "id": email},
    );
    controller.clear();
    scrollController.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
