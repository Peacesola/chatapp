import 'package:chat_app/utilities/route_helper.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/big_text.dart';
import '../../reusable_widgets/custom_elevated_button.dart';
import '../../reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/medium_texts.dart';
import '../../reusable_widgets/small_text.dart';
import '../../services/auth_service.dart';
import '../../services/firebase_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  AuthService service= AuthService();
  //AuthRepo repo = AuthRepo();
  bool isLoading= false;

  late FirebaseService firebaseService;

  @override
  void initState(){
    super.initState();
    email;
    password;

  }
  @override
  void dispose(){
    super.dispose();
    email;
    password;
  }

  void onClicked() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  /*Future<void> login() async{
      try{
         User? user= await repo.logIn(email: email.text.trim(), password: password.text.trim());
         if(user != null){
           Navigator.of(context).pushNamedAndRemoveUntil(bottomNavigator, (route) => false);
         }else{

         }
      }catch(e){
      }
      onClicked();
  }*/
  Future<void> login() async{
    await service.login(context,email.text.trim(),password.text.trim());
    //Navigator.of(context).pushNamedAndRemoveUntil(bottomNavigator, (route) => false);
    onClicked();
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
              Center(child: BigText(text: 'Login', color: Colors.black)),
              SizedBox(height: height*0.1,),
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
                if(email.text.isNotEmpty && password.text.isNotEmpty){
                  onClicked();
                  login();

                }
              }, text: 'Login',color: Colors.black, height: height*0.06, width: 0.01,),
              SizedBox(height: height*0.05,),
                Center(
                child: Column(
                  children: [
                    SmallText(text: 'Don\'t have an account?', color: Colors.black),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamedAndRemoveUntil(context, registerScreen, (route) => false);

                      },
                        child: MediumText(text: 'Register', color: Colors.black,fontWeight: FontWeight.w600,))
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
//padding: EdgeInsets.only(left: width*0.06,right: width*0.06,top: height*0.06,bottom: height*0.03),