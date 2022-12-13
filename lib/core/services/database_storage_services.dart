import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class DatabaseStorageServices{

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadUserImage(File image,String uuid) async{
    // final imagePath = image.path;
    try{
      var reference = _storage.ref().child("UserProfilesImages/$uuid");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot = await uploadImage.whenComplete(() => print('Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    }catch(e){
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }

  Future<String?> uploadUserCoverImage(File image,String fileName) async{
    // final imagePath = image.path;
    try{
      var reference = _storage.ref().child("images/$fileName");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot = await uploadImage.whenComplete(() => print('Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    }catch(e){
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }



}