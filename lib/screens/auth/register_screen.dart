import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/repos/auth_repo.dart';
import 'package:chat_app/reusable_widgets/alert_dialog.dart';
import 'package:chat_app/reusable_widgets/big_text.dart';
import 'package:chat_app/reusable_widgets/custom_elevated_button.dart';
import 'package:chat_app/reusable_widgets/custom_text_field.dart';
import 'package:chat_app/reusable_widgets/medium_texts.dart';
import 'package:chat_app/reusable_widgets/small_text.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/user_list.dart';
import 'package:chat_app/utilities/route_helper.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:http/http.dart'as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController name= TextEditingController();
  //AuthRepo repo = AuthRepo();
  AuthService service= AuthService();

  late FirebaseService firebaseService= FirebaseService();

  bool isLoading= false;
  @override
  void initState(){
    super.initState();
    email;
    password;
    name;
  }
  @override
  void dispose(){
    super.dispose();
    email;
    password;
    name;
  }
  void onClicked() {
    setState(() {
      isLoading = !isLoading;
    });
  }

/*
  Future<void> register() async {
    try{
      User? user=  await repo.signUp(email: email.text.trim(), password: password.text.trim());
      if(user != null){
        AppUser appUser= AppUser(uid: user.uid, email: email.text.trim(), name: name.text.trim());
        await repo.saveUserToFirestore(appUser);
        Navigator.of(context).pushNamedAndRemoveUntil(loginScreen, (route) => false);
      }else{

      }

     }catch(e){

     }
     onClicked();
}*/


  File? profileImage;
  String? base64Image;

  Future<void> register()async{
    await service.register(context,email.text.trim(), name.text.trim(), password.text.trim(),base64Image!);
    Navigator.of(context).pushNamedAndRemoveUntil(loginScreen, (route) => false);
    onClicked();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
    if (profileImage != null) {
      List<int> imageBytes = await profileImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
      //print('Base64 Image: ${base64Image?.substring(0, 30)}...');
    }
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: width*0.06,right: width*0.06,top: height*0.06,bottom: height*0.03),
        child: Center(
          child: ListView(
            children: [
               Center(child: BigText(text: 'Create an account', color: Colors.black)),
              SizedBox(height: height*0.05,),
              Center(
                child: Stack(
                  children: [
                    Container(
                        height: height*0.2,
                        width: width*0.45,
                        child: InkWell(
                            onTap: (){
                              pickImage(ImageSource.camera);
                            },
                            child: CircleAvatar(backgroundColor: Colors.grey[300],
                                child: profileImage == null? Icon(RemixIcons.camera_fill,size: height*0.08,color: Colors.black,):null,
                            backgroundImage: profileImage != null ? FileImage(profileImage!):null))),
                    Positioned(
                        right: width*0.03,
                        bottom: height* -0.015,
                        child: Container(
                          height: height*0.1,
                          width: width*0.1,
                          child: InkWell(
                              onTap: (){
                                pickImage(ImageSource.gallery);
                              },
                              child: CircleAvatar(backgroundColor: Colors.black,child: Icon(RemixIcons.add_fill,size: height*0.04,color: Colors.white,))),
                        ))
                  ] ,
                ),
              ),
              SizedBox(height: height*0.1,),
              CustomTextField(controller: name,hintText: 'Name',),
              SizedBox(height: height*0.05,),
              CustomTextField(controller: email,hintText: 'Email'),
              SizedBox(height: height*0.05,),
              CustomTextField(controller: password,hintText: 'Password'),
              SizedBox(height: height*0.05,),
              isLoading?SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ):
              CustomElevatedButton(onPressed: (){
                if(email.text.isNotEmpty && password.text.isNotEmpty && name.text.isNotEmpty){
                  onClicked();
                  register();
                }
              }, text: 'Register',color: Colors.black, height: height*0.06, width: width,),
              SizedBox(height: height*0.05,),
               Center(
                child: Column(
                  children: [
                    SmallText(text: 'Already have an account?', color: Colors.black),
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamedAndRemoveUntil(loginScreen, (route) => false);
                        },
                        child: MediumText(text: 'Login', color: Colors.black,fontWeight: FontWeight.w600,))
                  ],
                ),
              ),
              SizedBox(height: height*0.05,),
            ],
          ),
        ),
      ),
    );
  }
}
