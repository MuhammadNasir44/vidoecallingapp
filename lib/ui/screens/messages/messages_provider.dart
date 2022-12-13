



import 'dart:io';

import 'package:chat_call_feature/core/constants/models/conversation.dart';
import 'package:chat_call_feature/core/enums/view_state.dart';
import 'package:chat_call_feature/core/models/app_user.dart';
import 'package:chat_call_feature/core/services/auth_services.dart';
import 'package:chat_call_feature/core/services/databaseservices.dart';
import 'package:chat_call_feature/core/services/locator.dart';
import 'package:chat_call_feature/core/view_models/base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MessagesProvider extends BaseViewModal {


  bool isSearching = false;
  AppUser currentAppUser = AppUser();
  final locateUser = locator<AuthServices>();

  final formKey = GlobalKey<FormState>();
  List<AppUser> searchedUsers = [];
  List<AppUser> appUsers=[];
  List<AppUser> conversationUserList=[];
  List<AppUser> searchedAppUsers=[];
  DatabaseServices _databaseServices= DatabaseServices();
  final currentUser = locator<AuthServices>();
  final Conversation conversation = Conversation();
  List<Conversation> messages = [];
  final messageController = TextEditingController();
  Stream<QuerySnapshot>? getMessageStream;
  Stream<QuerySnapshot>? getConversationListStream;

  XFile? image;
  File? userImage;
  final ImagePicker imagePicker = ImagePicker();

  MessagesProvider(){
    currentAppUser = currentUser.appUser;
    print("Wht is this then what is the problem with that =========================+"+"${currentUser.appUser.userName}");
    getAppUsers();
    getUserConversationList();
  }
  ///
  /// Get all app users
  ///
  getAppUsers() async{
    setState(ViewState.busy);
    appUsers = await _databaseServices.getAllAppUser("AppUser");
    setState(ViewState.idle);
  }
  ///
  /// send message
  ///
  addUserMessages(String toUserId, Conversation conversation, AppUser toAppUser) async{
    if(formKey.currentState!.validate()){
      conversation.sentAt = DateTime.now().toString();
      var dateTime = DateTime.now();
      var onlyTime = DateFormat.jm();
      toAppUser.createdAt = onlyTime.format(dateTime).toString();
      // toAppUser.createdAt = DateTime.now().toString();
      conversation.sender = currentUser.appUser.appUserId!;
      toAppUser.lastMessage = conversation.messageText;
      currentAppUser.createdAt = onlyTime.format(dateTime).toString();
      currentAppUser.lastMessage = conversation.messageText;
      currentAppUser.lastMessageAt = DateTime.now().toString();
      // toAppUser.createdAt = DateTime.now().toString();
      messageController.clear();
      await _databaseServices.addUserMessage(currentAppUser, toUserId, conversation, toAppUser);
      print(currentAppUser.lastMessage);

    }
  }
  pickImageFromGallery() async{
    image = (await imagePicker.pickImage(source: ImageSource.gallery));
    if(image != null){
      userImage = File(image!.path);
      print("UserImagePath=>${userImage!.path}");
      notifyListeners();
    }
  }

  // ///
  // /// Get user messages using stream
  // ///
  // getAllMessages(String toUserId) async{
  //   print("ToUserId => $toUserId");
  //   setState(ViewState.busy);
  //   getMessageStream =  _databaseServices.getRealTimeChat(currentUser.appUser.appUserId!, toUserId);
  //   getMessageStream!.listen((event) {
  //     messages = [];
  //     if(event.docs.length > 0){
  //       event.docs.forEach((element) {
  //         messages.add(Conversation.formJson(element, element.id));
  //         notifyListeners();
  //         print('Message from stream');
  //         print('Messages length ${messages.length}');
  //       });
  //      notifyListeners();
  //     }
  //     else{
  //       messages = [];
  //       notifyListeners();
  //     }
  //   });
  //   // messages = await _databaseServices.getAllMessages(currentUser.appUser.appUserId!, toUserId);
  //   setState(ViewState.idle);
  // }
  ///
  /// Get conversation list
  ///
  getUserConversationList() async{
    setState(ViewState.busy);
    getConversationListStream = _databaseServices.getUserConversationList(currentUser.appUser);
    getConversationListStream!.listen((event) {
      conversationUserList = [];
      if(event.docs.length > 0){
        event.docs.forEach((element) {
          conversationUserList.add(AppUser.fromJson(element, element.id));
          notifyListeners();
        });
      }
    });
    setState(ViewState.idle);
  }







  ///
  /// convert appbar into searching mode
  ///
  searchingMode(){
    if(isSearching)
    {
      isSearching=false;
    }
    else{
      isSearching=true;
    }
    notifyListeners();
  }
  ///
  /// search user by name
  ///
  searchUserByName(String keyword){
    print("Searched keyword : $keyword");
    keyword.isEmpty ? isSearching = false : isSearching = true;
    searchedUsers = conversationUserList.where((e) =>
    (e.userName!.toLowerCase().contains(keyword.toLowerCase()))).toList();

    searchedAppUsers = appUsers.where((e) =>
    (e.userName!.toLowerCase().contains(keyword.toLowerCase()))).toList();
    notifyListeners();
  }




}