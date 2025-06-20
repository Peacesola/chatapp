import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  /*final ImagePicker picker = ImagePicker();

  *//*final AuthRepo repo= AuthRepo();
  ChatRepository chatRepository= ChatRepository();*//*

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
    }
  }*/


}


/*Future<void> uploadImage(File image) async {
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
  }*//*



  Future<String> uploadImage(File imageFile, String receiverId) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('chat_images')
        .child(receiverId)
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    UploadTask uploadTask = storageRef.putFile(imageFile);

    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> selectGalleryAndSend(String senderId, String receiverId) async {
    File? imageFile = await pickImageFromGallery();
    if (imageFile != null) {
      final imageUrl = await uploadImage(imageFile, receiverId);
      await chatRepository.sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        imageUrl: imageUrl,
      );
    }
  }

// Example function to pick from camera and send
  Future<void> selectCameraAndSend(String senderId, String receiverId) async {
    final imageFile =  await pickImageFromCamera();
    if (imageFile != null) {
      final imageUrl = await uploadImage(imageFile, receiverId);
      await chatRepository.sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        imageUrl: imageUrl,
      );
    }
  }


}*/
