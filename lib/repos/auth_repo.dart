

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../reusable_widgets/alert_dialog.dart';

class AuthRepo{
    final FirebaseAuth _firebaseAuth;
    final FirebaseFirestore _firestore= FirebaseFirestore.instance;

   AuthRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

    User? getCurrentUser() {
      return _firebaseAuth.currentUser;
    }

    Future<User?> signUp({required String email, required String password}) async {
     // final user= getCurrentUser();
       *//* try{
          final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          return userCredential.user;
        }on FirebaseAuthException catch(e){
          if (e.code == 'email-already-in-use') {
            //print('The account already exists for that email');
            await CustomDialog(text: 'The account already exists for that email');
            return null;
          } else if (e.code == 'weak-password') {
           // print('The password provided is too weak.');
            await CustomDialog(text: 'The password provided is too weak.');
            return null;
          } else if (e.code == 'invalid-email') {
            //print('The email address is not valid.');
            await CustomDialog(text: 'The email address is not valid.');
            return null;
          } else {
            //print('Registration failed: ${e.message}');
           await CustomDialog(text: 'Registration failed: ${e.message}');
           return null;
          }
          return null;
        }*//*
    }

    Future<User?> logIn({required String email, required String password}) async {
        *//*try{
          final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          return userCredential.user;
        }on FirebaseAuthException catch(e){
          if (e.code == 'user-not-found') {
           // print('No user found for that email.');
            await CustomDialog(text: 'No user found for that email.');
            return null;
          } else if (e.code == 'wrong-password') {
           //print('Wrong password provided for that user.');
            await CustomDialog(text: 'Wrong password provided for that user.');
            return null;
          } else if (e.code == 'invalid-email') {
            //print('The email address is badly formatted.');
           await CustomDialog(text: 'The email address is badly formatted.');
           return null;
          } else {
           // print('Login failed: ${e.message}');
            await CustomDialog(text: 'Error logging in');
            return null;
          }
          return null;
        }*//*
    }

    Future<void> saveUserToFirestore(AppUser user) async {
      try {
        await _firestore.collection('users').doc(user.uid).set(user.toMap());
      } catch (e) {
        print('Failed to save user to Firestore: $e');
      }
    }

    Future<void> logOut() async {
      await _firebaseAuth.signOut();
    }

    Future<AppUser?> getUserFromFirestore(String uid) async {
      try {
        final userDoc = await _firestore.collection('users').doc(uid).get();
        if (userDoc.exists) {
          return AppUser.fromMap(userDoc.data()!, uid);
        }
        return null;
      } catch (e) {
        rethrow;
      }
    }


}*/
/*Future<List<Map<String,dynamic>>> getUserFromFirestore(String currentUserId) async {
      //String currentUserId = _firebaseAuth.currentUser!.uid;
      try {
        final userDoc = await _firestore.collection('users').where('uid',isNotEqualTo: currentUserId).get();
       // if (userDoc.exists) {
          return userDoc.docs.map((e) => e.data()).toList();
       // }
      //  return null;
      } catch (e) {
        rethrow;
      }
    }
*/