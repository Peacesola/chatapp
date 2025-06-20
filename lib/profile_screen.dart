import 'package:chat_app/repos/auth_repo.dart';
import 'package:chat_app/reusable_widgets/alert_dialog.dart';
import 'package:chat_app/reusable_widgets/custom_elevated_button.dart';
import 'package:chat_app/reusable_widgets/medium_texts.dart';
import 'package:chat_app/reusable_widgets/small_text.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/utilities/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   AuthService service= AuthService();
    String? profileImage;
     String? email;


  @override
  void initState(){
    super.initState();
    getUserInfo();
    //print(token);
   // profileImage= service.getCurrentProfileImage();
  }



  Future<void>getUserInfo()async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    setState(() {
      email= prefs.getString("email");
    });
  }
Future<void>logout()async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  prefs.remove("accessToken");
  Navigator.of(context).pushNamedAndRemoveUntil(loginScreen, (route) => false);

}


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: MediumText(text: "Profile", color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
            padding: EdgeInsets.only(left: width*0.06,right: width*0.06,top: height*0.02,bottom: height*0.03),
            child: Center(
              child: Column(
                children: [
                 Column(
                   children: [
                     Container(
                         height: height*0.2,
                         width: width*0.45,
                         child: FutureBuilder<Map<String, dynamic>?>(
                             future: service.fetchUserProfile(),
                             builder: (context, snapshot) {
                               if(snapshot.connectionState==ConnectionState.waiting){
                                 return CircleAvatar(
                                     backgroundColor: Colors.grey[300]
                                 );
                               }if(snapshot.hasError){
                                 return CircleAvatar(
                                     backgroundColor: Colors.grey[300],
                                     child:  Icon(RemixIcons.file_warning_line,size: height*0.08,color: Colors.grey,),
                                 );
                               }if(!snapshot.hasData){
                                 return CircleAvatar(
                                     backgroundColor: Colors.grey[300],
                                     child:  Icon(RemixIcons.user_fill,size: height*0.08,color: Colors.grey,),
                                 );
                               }
                               final user = snapshot.data;
                               return GestureDetector(
                                 onTap: (){
                                   print(user);
                                   //showImageDialog(context, profileImage!);

                                 },
                                 child: CircleAvatar(
                                     backgroundImage: NetworkImage(profileImage!)
                                 ),
                               );
                             },),
                     ),
                     SizedBox(
                       height: height*0.02,
                     ),
                     MediumText(text: email!, color: Colors.black),
                   ],
                 ),
                  SizedBox(
                    height: height*0.02,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          logout();
                           //showLogout(context,logout);
                        },
                        child: Row(
                          children: [
                            MediumText(text: "Logout", color: Colors.black),
                            Icon(RemixIcons.logout_box_r_line)
                          ],
                        ),
                      )
                    ],
                  )// second column
                ],
              ),
            ),
          )

        /*child: Center(
          child: CustomElevatedButton(
              color: Colors.black,
              onPressed: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(loginScreen, (route) => false);
          }, text: "Logout", height: height*0.06, width: width*0.2),
        ),*/

    );
  }
}
/*return CircleAvatar(
                                   backgroundColor: Colors.grey[300],
                                   child: profileImage == null ? Icon(RemixIcons.user_fill,size: height*0.08,color: Colors.grey,):null,
                                   backgroundImage: profileImage != null ? NetworkImage(profileImage!):null
                               );*/