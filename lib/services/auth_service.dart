import 'dart:convert';
import 'package:chat_app/reusable_widgets/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/route_helper.dart';

class AuthService{
  final String baseUrl= "https://springboot-chat-backend.onrender.com";
  final String registerUrl= "https://springboot-chat-backend.onrender.com/api/auth/register";
  final String loginUrl= "https://springboot-chat-backend.onrender.com/api/auth/login";
  final String userListUrl="https://springboot-chat-backend.onrender.com/api/auth/users";
  final String profileImage= "https://springboot-chat-backend.onrender.com/uploads/image.jpg";
  final String userProfile= "https://springboot-chat-backend.onrender.com/api/auth/profile";

  Future<void>register(BuildContext context,String email,String username,String password,String? profileImageUrl) async {
    final url= Uri.parse(registerUrl);
    final body= jsonEncode({"email":email,"username":username,"password":password,"profileImage":profileImageUrl});
    
    final response= await http.post(
        url,
      headers: {'Content-Type': 'application/json'},
      body: body
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final  profileImage= data['imageUrl'];
      SharedPreferences prefs= await SharedPreferences.getInstance();
      prefs.setString("profileImage",profileImage );
      prefs.setString("email", email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data['message'],
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            Icons.check_circle,
            color: Colors.white,
          )
        ],
      )));
      Navigator.of(context).pushNamedAndRemoveUntil(loginScreen, (route) => false);
      print(data);
    } else {
      //print('Signup failed: ${data['error']}');
     // await CustomDialog(text: data["error"]);
      await showErrorDialog(context, data["error"]);
    }
  }

  Future<void> login(BuildContext context,String email, String password) async {
    final url = Uri.parse(loginUrl);
    final body = jsonEncode({'email': email, 'password': password});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String token= data["token"];
      final prefs= await SharedPreferences.getInstance();
      await prefs.setString('accessToken',token );
      await prefs.setString("email", email);
     // print('data; $data');
      print('token; $token');

      Navigator.of(context).pushNamedAndRemoveUntil(bottomNavigator, (route) => false);

    } else {
      //await CustomDialog(text: data);
      //print('Login failed: ${response.statusCode}');
      await showErrorDialog(context, data["error"]);
      print('Login failed: ${data['error']}');
    }
  }
  Future<String?>getToken()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    final token=prefs.getString('accessToken');
    return token;
  }

  Future<Map<String, dynamic>>fetchUserProfile()async{
    final token= await getToken();
    final url = Uri.parse(userProfile);
    try{
      final response = await http.get(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print(token);
      if (response.statusCode == 200){
        final data = jsonDecode(response.body);
        print('Data received: $data');
        return data['user'];

      }else{
        throw Exception('An error occurred');
      }
    }catch(e){
      print('error: $e');
      throw Exception('An error occurred');
    }
  }

  Future<List<Map<String, dynamic>>> fetchUsers()  async {
    final url = Uri.parse(userListUrl);
    final response = await http.get(url);
    if (response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      print('Data received: $data');
      return data.map((user) => user as Map<String,dynamic>).toList();

    }else{
      throw Exception('Failed to load users');
    }

  }


}
