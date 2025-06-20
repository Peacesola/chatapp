import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppUser{
  late final String uid;
  late final String email;
  late final String name;
  late final String? profileImageUrl;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    this.profileImageUrl
});


  factory AppUser.fromMap(Map<String,dynamic> map,String uid){
    return AppUser(uid: uid,
        email: map['email']?? '',
        name: map['name']?? '',
        profileImageUrl: map['profileImageUrl']?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
factory AppUser.fromFirebase(User user){
    return AppUser(uid: user.uid, email: user.email!, name: user.displayName?? '');
}

}

