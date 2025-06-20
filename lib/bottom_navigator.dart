import 'package:chat_app/profile_screen.dart';
import 'package:chat_app/user_list.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex=0;
  final List<Widget> _pages = [
    UserList(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(/*iconSize: height*,*/
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          }
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(RemixIcons.chat_3_line),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(RemixIcons.user_fill),
            label: 'Profile',
          ),
        ],),
    );
  }
}
