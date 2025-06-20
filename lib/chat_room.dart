import 'dart:convert';

import 'package:chat_app/image_methods.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/repos/chat_repo.dart';
import 'package:chat_app/reusable_widgets/custom_chat_bubble.dart';
import 'package:chat_app/reusable_widgets/custom_chat_bubble2.dart';
import 'package:chat_app/reusable_widgets/custom_text_field.dart';
import 'package:chat_app/reusable_widgets/image_bubble.dart';
import 'package:chat_app/reusable_widgets/medium_texts.dart';
import 'package:chat_app/reusable_widgets/small_text.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'dart:io';
import 'models/user_model.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  List<String> chatMessage = [];
  ChatRepository chatRepository = ChatRepository();
  TextEditingController messageController = TextEditingController();
  String? sender;
  String? receiver;
  String? name;
  String? profileImage;
  bool isTyping = false;
  String? loggedInUser;
  final ScrollController scrollController = ScrollController();
  File? image;
  final ImagePicker picker = ImagePicker();
  ChatRepository repository = ChatRepository();
  StompClient? stompClient;

  @override
  void initState() {
    getUserInfo();
    void onConnect(StompFrame frame) {
      stompClient?.subscribe(
        destination: '/user/private',
        callback: (StompFrame frame) {
          final body = jsonDecode(frame.body!);
          setState(() {
            chatMessage.add('${body['senderId']}: ${body['content']}');
          });
          /* print (chatMessage);
          print("Received message: ${chatMessage['content']}");*/
        },
      );
    }

    void connectToWebSocket() {
      final stompClient = StompClient(
        config: StompConfig.sockJS(
          url: 'https://springboot-chat-backend.onrender.com/ws',
          onConnect: onConnect,
          onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
          /*stompConnectHeaders: {'Authorization': 'Bearer your_jwt_token'},
        webSocketConnectHeaders: {'Authorization': 'Bearer your_jwt_token'},*/
          onStompError: (frame) {
            print('Stomp Error: ${frame.body}');
          },
          onDisconnect: (frame) {
            print('Disconnected');
          },
        ),
      );

      stompClient.activate();
    }

    /*WidgetsBinding.instance.addPostFrameCallback((_) {
    });*/
    //repository.sendMessage(senderId: sender, receiverId: receiver, message: message.text.trim());
    super.initState();
    messageController;
  }

  Future<void> sendMessage(
      /*String receiver, String sender, String content,*/) async {
    final message = {
      'sender': sender,
      'recipient': receiver,
      'content': messageController.text.trim(),
      'timestamp': DateTime.now().toIso8601String(),
    };
    final data = jsonEncode(message);
    print(data);
    stompClient?.send(
      destination: '/app/private',
      body: data,
    );
    setState(() {
      chatMessage.add(messageController.text);
      messageController.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    messageController;
  }

  Future<void> scrollUp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedInUser = prefs.getString("email")!;
    print('sender:$loggedInUser');
  }

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /*Future<void>sendMessage()async{
    repository.sendMessage(receiver!, sender!, message.text.trim());
  }*/

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    sender = args['sender'];
    receiver = args['receiver'];
    name = args["name"];
    profileImage = args["profileImage"];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: profileImage == null
                    ? Icon(
                        RemixIcons.user_fill,
                        color: Colors.black,
                      )
                    : null,
                backgroundImage:
                    profileImage != null ? NetworkImage(profileImage!) : null,
              ),
              SizedBox(width: width * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MediumText(
                      text: sender == receiver ? name! + " " + "(You)" : name!,
                      color: Colors.black),
                  SmallText(text: 'Data', color: Colors.black)
                ],
              )
            ],
          ),
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                RemixIcons.arrow_left_long_line,
                color: Colors.black,
              )),
          actions: [
            Icon(
              RemixIcons.video_on_line,
              color: Colors.black,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Icon(
              RemixIcons.phone_line,
              color: Colors.black,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Icon(
              RemixIcons.more_2_fill,
              color: Colors.black,
            ),
            SizedBox(
              width: width * 0.04,
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: chatMessage.length,
                  itemBuilder: (context, index) {
                    final isMe = sender == loggedInUser;
                    final messages = chatMessage[index];
                    print(isMe);
                    return isMe
                        ? CustomChatBubble(text: messages)
                        : CustomChatBubble2(text: messages);
                    // }
                  }),
            ),
            Container(
              padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
              //height: height*0.09,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextField(
                      onChanged: (value) {
                        setState(() {
                          isTyping = value.trim().isNotEmpty;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: null,
                      controller: messageController,
                      prefixIcon: Icon(
                        RemixIcons.emoji_sticker_line,
                        color: Colors.black,
                      ),
                      hintText: 'Message',
                      suffixIcon: InkWell(
                          onTap: () {},
                          onDoubleTap: () {},
                          child: Icon(
                            RemixIcons.camera_line,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  isTyping
                      ? SizedBox(
                          width: width * 0.02,
                        )
                      : Container(),
                  isTyping
                      ? CircleAvatar(
                          child: InkWell(
                              onTap: () {
                                if (messageController.text.isNotEmpty) {
                                  print('sender:$sender');
                                  print('receiver:$receiver');
                                  sendMessage();

                                  //repository.sendMessage(receiver, sender, message.text.trim());
                                  messageController.clear();
                                  scrollUp();
                                }
                              },
                              child: Icon(
                                RemixIcons.send_plane_2_line,
                                color: Colors.white,
                              )),
                          backgroundColor: Colors.black,
                        )
                      : Container()
                ],
              )),
            ) // textfield
          ],
        ));
  }
}
