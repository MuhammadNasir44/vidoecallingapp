
import 'package:chat_call_feature/core/constants/models/friend_model.dart';
import 'package:chat_call_feature/core/enums/view_state.dart';
import 'package:chat_call_feature/ui/screens/signin/sign_in_screen.dart';
import 'package:chat_call_feature/widgets/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';
import 'messages_provider.dart';

class UsersListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessagesProvider(),
      child: Consumer<MessagesProvider>(
        builder: (ctx, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Users"),
                  FlatButton(onPressed: ()
                      async {
                        await model.locateUser.logoutUser();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                      },
                      child: Text("Logout"))

                ],
              )
            ),
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.busy,
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(
                color: Colors.red,
              ),
              child: Container(
                color: Color(0xffE5E5E5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      model.appUsers.isEmpty?Center(child: Text("No Other Users"),):
                      ListView.builder(
                        itemCount: model.appUsers.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()
                            {
                              Navigator.push(context, CustomPageRoute(child: ChatScreen(toAppUser: model.appUsers[index],)));
                              // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ChatScreen(toAppUser: model.appUsers[index],)));
                            },
                              // Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatScreen(toAppUser: model.appUsers[index] )));
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              margin: EdgeInsets.only(
                                  left: 15.w, right: 15.w, top: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  model.appUsers[index].imageUrl!=null?CircleAvatar(
                                    radius: 28.2,
                                    backgroundImage: NetworkImage("${model.appUsers[index].imageUrl}"),
                                    backgroundColor: Colors.grey,
                                  ):
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 28.w,
                                    backgroundImage:
                                    AssetImage(friendsListItems[index].img,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                           model.appUsers[index].userName.toString(),
                                            // friendsListItems[index].name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17.sp),
                                          ),
                                          Text(
                                            model.appUsers[index].description.toString(),
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(),
                                              Text(
                                                "3:52 pm",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // buildAllUserScreen(MessageProvider model, BuildContext context) {
  //   return model.appUsers.isEmpty ? Center(child: Text("No users found"))
  //       : ListView.separated(
  //     separatorBuilder: (context, index) {
  //       return Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 23.0),
  //         child: Divider(
  //           thickness: 1,
  //           color: primaryColor,
  //         ),
  //       );
  //     },
  //     padding: EdgeInsets.symmetric(vertical: 5),
  //     itemCount: model.isSearching == false ? model.appUsers.length : model
  //         .searchedAppUsers.length,
  //     itemBuilder: (context, index) {
  //       return Column(
  //         children: [
  //           model.isSearching == false ? Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 8.0),
  //             child: ListTile(
  //               tileColor: Theme
  //                   .of(context)
  //                   .cardColor,
  //               contentPadding: EdgeInsets.symmetric(
  //                   vertical: 5, horizontal: 10),
  //               onTap: () async {
  //                 print(model.appUsers[index].appUserId);
  //                 // await model.getAllMessages(model.appUsers[index].appUserId!);
  //                 Navigator.push(context, CustomPageRoute(
  //                     child: ChatScreen(toAppUser: model.appUsers[index],)));
  //               },
  //               leading: model.appUsers[index].imageUrl == null ? CircleAvatar(
  //                 radius: 30.r,
  //                 backgroundImage: AssetImage('assets/icons/profile_icon.png'),
  //               ) : CircleAvatar(
  //                 radius: 30.r,
  //                 // backgroundColor: Colors.transparent,
  //                 backgroundImage: NetworkImage(
  //                     '${model.appUsers[index].imageUrl}'),
  //               ),
  //               title: Text(model.appUsers[index].userName!),
  //             ),
  //           ) : Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 8.0),
  //             child: ListTile(
  //               tileColor: Theme
  //                   .of(context)
  //                   .cardColor,
  //               contentPadding: EdgeInsets.symmetric(
  //                   vertical: 5, horizontal: 10),
  //               onTap: () async {
  //                 // await model.getAllMessages(model.searchedUsers[index].appUserId!);
  //                 Navigator.push(context, CustomPageRoute(child: ChatScreen(
  //                   toAppUser: model.searchedAppUsers[index],)));
  //               },
  //               leading: model.searchedAppUsers[index].userName == null
  //                   ? CircleAvatar(
  //                 radius: 30.r,
  //                 backgroundImage: AssetImage('assets/icons/profile_icon.png'),
  //               )
  //                   : CircleAvatar(
  //                 radius: 30.r,
  //                 backgroundColor: Colors.transparent,
  //                 backgroundImage: NetworkImage(
  //                     '${model.searchedAppUsers[index].imageUrl}'),
  //               ),
  //               title: Text(model.searchedAppUsers[index].userName!),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }




}
