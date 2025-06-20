
import 'dart:convert';
import 'dart:io';

import 'package:chat_app/repos/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../models/message_model.dart';

class ChatRepository {
 late ChatMessage chatMessage;
  late StompClient stompClient;

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

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/user/private',
      callback: (StompFrame frame) {
        final data = jsonDecode(frame.body!);

        print("Received message: ${data['content']}");

      },
    );
  }


Future<void> sendMessage(String receiver, String sender, String content, /*String? image*/)async {
  final message = {
    'sender': sender,
    'recipient': receiver,
    'content': content,
    'timestamp': DateTime.now().toIso8601String(),
  };
  final data=jsonEncode(message);
   print(data);
  stompClient.send(
    destination: '/app/private',
    body: data,
  );
}
Future<void>receiveMessage()async {

}



}
/*final FirebaseFirestore _firestore;

  ChatRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  AuthRepo repo= AuthRepo();

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
     String? message,
    String? imageUrl
  }) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      final messageData = {
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'timestamp': timestamp,
        //'imageUrl': imageUrl
      };
      if (imageUrl != null && imageUrl.isNotEmpty) {
        messageData['imageUrl'] = imageUrl;
      }

      await _firestore
          .collection('chats')
          .doc(_getChatId(senderId, receiverId))
          .collection('messages')
          .add(messageData);
    } catch (e) {
      rethrow;
    }
  }


  Stream<List<ChatMessage>> getMessages({
    required String senderId,
    required String receiverId,
  }) {
    return _firestore
        .collection('chats')
        .doc(_getChatId(senderId, receiverId))
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map<ChatMessage>((doc) => ChatMessage.fromMap(doc.data()))
          .toList();
    });
  }

  String _getChatId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode
        ? '${user1}_$user2'
        : '${user2}_$user1';
  }

Future<void> uploadImage(File image) async {
    try {
      // 1. Create a unique file name
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // 2. Upload image to Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child('chatImages/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);

      TaskSnapshot snapshot = await uploadTask;

      // 3. Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // 4. Save the download URL into Firestore
      await FirebaseFirestore.instance.collection('messages').add({
        'imageUrl': downloadUrl,
        'createdAt': Timestamp.now(),
        'senderId': repo.getCurrentUser()!.uid, // replace with your current user id
        'receiverId': 'yourReceiverId', // replace with the receiver's id
      });

      //print('Image uploaded and URL saved to Firestore!');
    } catch (e) {
     // print('Error uploading image: $e');
    }
  }*/
