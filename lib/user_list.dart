import 'package:chat_app/repos/auth_repo.dart';
import 'package:chat_app/reusable_widgets/custom_chat_tile.dart';
import 'package:chat_app/reusable_widgets/custom_list_tile.dart';
import 'package:chat_app/reusable_widgets/custom_text_field.dart';
import 'package:chat_app/reusable_widgets/medium_texts.dart';
import 'package:chat_app/reusable_widgets/small_text.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/utilities/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_model.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  TextEditingController search= TextEditingController();
  // AuthRepo repo= AuthRepo();
     String? senderId;
   AuthService service= AuthService();
   SharedPreferences? preferences;
   /*Future<void>saveProfileImage() async {
     SharedPreferences prefs= await SharedPreferences.getInstance();
     setState(() {
       savedProfileImage= prefs.setString('savedProfileImage', profileImage);
     });
   }*/


  Future<void>getUserInfo()async {
     SharedPreferences prefs= await SharedPreferences.getInstance();
    //setState(() {
      senderId= prefs.getString("email")!;
      print('sender:$senderId');
    //});
    //return senderId;
  }




  @override
  void initState(){
    super.initState();
    service.fetchUsers();
    getUserInfo();
    search;
  }
  @override
  void dispose(){
    super.dispose();
    search;
  }
  @override
  Widget build(BuildContext context) {
  //  String currentUserId = auth.currentUser!.uid;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: height*0.06,
        title: MediumText(text: 'ChatApp', color: Colors.black,fontWeight: FontWeight.w600,),
        actions: [
              Icon(RemixIcons.camera_line,color: Colors.black,),
              SizedBox(width: width*0.03,),
              Icon(RemixIcons.more_2_fill,color: Colors.black,),
          SizedBox(width: width*0.04,),
            ],
          ),
      body: FutureBuilder<List<Map<String,dynamic>>>(
        future: service.fetchUsers(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(color: Colors.black,),
            );
          }if(!snapshot.hasData){
            return Center(
              child: MediumText(color: Colors.black,text: 'No users',),
            );
          }if(snapshot.hasError){
            return Center(
              child: MediumText(color: Colors.black,text: 'Error displaying users',),
            );
          }
          return ListView(
            children: [
              SizedBox(
                height: height*0.02,
              ),
              Container(
                  height: height*0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                    child: CustomTextField(
                      controller: search,hintText: 'Search',prefixIcon: Icon(RemixIcons.search_line,color: Colors.black,),),
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: user?.length,
                  itemBuilder: (context,index){
                    final users= user?[index];
                    //print(users);
                    //print(senderId);
                    final receiverId= users?["email"];
                    final name= users?["username"];
                    final profileImage= users?["profileImageUrl"];
                    // preferences?.setString('savedProfileImage', profileImage);
                   // print(receiverId);
                    //print(profileImage);
                    return CustomChatTile(
                        widget1:  Icon(RemixIcons.user_fill,color: Colors.grey,),
                        url: profileImage!,
                        widget2: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MediumText(text: senderId== receiverId? name!+" "+"(You)":name!, color: Colors.black,fontWeight: FontWeight.w500),
                            SmallText(text: "Text", color: Colors.black,fontWeight: FontWeight.w500),
                          ],
                        ),
                        widget3: Column(
                          children: [
                            SmallText(text: '19 mins ago', color: Colors.black),
                            SizedBox(
                                height: height*0.025,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Center(child: SmallText(text: '2', color: Colors.white,)),
                                )),
                          ],
                        ), onTap: (){
                      Navigator.pushNamed(context, chatRoom,arguments: {
                        "sender":senderId,
                        "receiver":receiverId,
                        "name":name,
                        "profileImage":profileImage
                      }
                      );
                    },
                    );
                  }),
              SizedBox(
                height: height*0.02,
              ),
            ],

          );
        }
      )
    );
  }
}
/*return CustomChatTile(
                        widget1:  Icon(RemixIcons.user_fill,color: Colors.grey,),
                        url: users!["profileImage"],
                        widget2: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MediumText(text: users!["username"], color: Colors.black,fontWeight: FontWeight.w500),
                            SmallText(text: "Text", color: Colors.black,fontWeight: FontWeight.w500),
                          ],
                        ),
                        widget3: Column(
                          children: [
                            SmallText(text: '19 mins ago', color: Colors.black),
                            SizedBox(
                                height: height*0.025,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Center(child: SmallText(text: '2', color: Colors.white,)),
                                )),
                          ],
                        ), onTap: (){
                      Navigator.pushNamed(context, chatRoom,arguments: {
                               /*'sender': auth.currentUser?.uid,   // This should be an AppUser
                               'receiver': users*/
                      }
                      );
                    },
                        //url: users!["profileImage"] !=null? users!["profileImage"]:null
                    );*/

/*return Padding(
                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02,top: height*0.01),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: height*0.06,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[300],
                                        child: users!["profileImage"]==null?Icon(RemixIcons.user_fill,color: Colors.grey,):null,
                                        backgroundImage: NetworkImage(users!["profileImage"]),
                                      )
                                    /*Container(
                    height: height*0.06,
                    width: width*0.1,
                    child: widget.widget1,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      //image: DecorationImage(image: NetworkImage(widget.url),fit: BoxFit.cover)
                    ),
                  ),*/
                                  ),
                                  SizedBox(
                                    width: width*0.03,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MediumText(text: users!["username"], color: Colors.black,fontWeight: FontWeight.w500),
                                      SmallText(text: "Text", color: Colors.black,fontWeight: FontWeight.w500),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  SmallText(text: '19 mins ago', color: Colors.black),
                                  SizedBox(
                                      height: height*0.025,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: Center(child: SmallText(text: '2', color: Colors.white,)),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );*/