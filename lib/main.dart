




import 'package:chat_app/bottom_navigator.dart';
import 'package:chat_app/chat_room.dart';
import 'package:chat_app/profile_screen.dart';
import 'package:chat_app/reusable_widgets/alert_dialog.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/auth/register_screen.dart';
import 'package:chat_app/user_list.dart';
import 'package:chat_app/utilities/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MaterialApp(
   // navigatorKey: navigatorKey,
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
    routes: {
      loginScreen: (context){return LoginScreen();},
      registerScreen: (context){return RegisterScreen();},
      userList: (context){return UserList();},
      chatRoom: (context){return ChatRoom();},
      bottomNavigator: (context){return BottomNavigator();},
      profileScreen: (context){return ProfileScreen();}
    },
  ));
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {
    return BottomNavigator(

    );
  }
}
