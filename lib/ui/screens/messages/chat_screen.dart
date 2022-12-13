
import 'package:chat_call_feature/core/constants/models/friend_model.dart';
import 'package:chat_call_feature/core/constants/styles.dart';
import 'package:chat_call_feature/core/enums/view_state.dart';
import 'package:chat_call_feature/core/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'messages_provider.dart';


class ChatScreen extends StatelessWidget {
  final AppUser? toAppUser;

  ChatScreen({this.toAppUser});

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
      create: (context)=>MessagesProvider(),
      child:
      Consumer<MessagesProvider>(
        builder: (context, model, child){
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              // backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: toAppUser!.imageUrl == null ? CircleAvatar(
                    backgroundImage: AssetImage(friendsListItems[0].img),
                  ):CircleAvatar(
                    backgroundImage: NetworkImage("${toAppUser!.imageUrl}"),
                  ),
                  title: Text(
                    "${toAppUser!.userName}",
                    style: TextStyle(color: Colors.white)
                  ),
                ),
                // shape: appBarShape,
              ),
              ///
              /// body
              ///
              body: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///
                    /// Messages
                    ///
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Conversations").doc(model.currentUser.appUser.appUserId).collection("Chats").doc(toAppUser!.appUserId!)
                        .collection("messages").orderBy('sentAt',descending: true)
                        .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {

                        if (snapshot.hasData) {
                        // print(snapshot.data!.docs["messageText"]);
                        // return Text('message')
                        return Expanded(
                          child: ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc = snapshot.data!.docs[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal:15 ,vertical: 10),
                                  child: Align(alignment: (doc["sender"] == model.currentUser.appUser.appUserId ? Alignment.topRight : Alignment.topLeft),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: textFiledContainerStyle.copyWith(color: doc["sender"] == model.currentUser.appUser.appUserId! ?
                                          Colors.red: Colors.white),
                                      child: Text("${doc['messageText']}",
                                        style: TextStyle(
                                          color: doc["sender"]!= model.currentUser.appUser.appUserId! ? Colors.grey: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                        } else {
                            return Text("No Messages found");}
                        },
                    ),
                    ///
                    ///
                    // Expanded(
                    //   child: model.messages.isEmpty ? Center(child: Text('No Messages'),) : ListView.builder(
                    //       reverse: true,
                    //       itemCount: model.messages.length,
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //           padding: EdgeInsets.symmetric(horizontal:15 ,vertical: 10),
                    //           child: Align(
                    //             alignment: (model.messages[index].sender == model.currentUser.appUser.appUserId ? Alignment.topRight : Alignment.topLeft),
                    //             child: Container(
                    //               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    //               decoration: textFiledContainerStyle.copyWith(color: model.messages[index].sender == model.currentUser.appUser.appUserId! ? primaryColor : Theme.of(context).backgroundColor),
                    //               child: Text(
                    //                 "${model.messages[index].messageText}",
                    //                 style: TextStyle(
                    //                   color: model.messages[index].sender != model.currentUser.appUser.appUserId! ? Theme.of(context).accentColor: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),
                    ///
                    /// send message
                    ///
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                      child: Form(
                        key: model.formKey,
                        child: TextFormField(

                          validator: (value){
                            if(value != null||value!.isNotEmpty){
                              model.conversation.messageText = value;
                            }
                            else if(value.isEmpty){
                              return '';
                            }
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          controller: model.messageController,
                          decoration: InputDecoration(
                            hintText: "Message...",
                            // prefixIcon: GestureDetector(
                            //   onTap: () async {
                            //     model.pickImageFromGallery();
                            //   //
                            //   //   model.model.image;conversation.messageText =
                            //   //   // setState(ViewState.busy);
                            //   //   // imageUrl = await databaseStorageServices.uploadUserImage(userImage!, locateUser.appUser.appUserId!);
                            //   //   print("Sent to User :${toAppUser!.appUserId}");
                            //   //   model.addUserMessages(toAppUser!.appUserId!, model.conversation, toAppUser!);
                            //   // },
                            //   // child: Icon(Icons.eleven_mp)
                            // ),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                  print("Sent to User :${toAppUser!.appUserId}");

                                  model.addUserMessages(toAppUser!.appUserId!, model.conversation, toAppUser!);
                              },
                              child: Icon(Icons.send),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: Theme.of(context).primaryColor)
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
       ),
    );
  }
}