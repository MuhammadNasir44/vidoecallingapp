

import 'package:chat_call_feature/core/constants/models/conversation.dart';
import 'package:chat_call_feature/core/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_services.dart';
import 'locator.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;
  /// Add user
  ///
  registerUser(AppUser appUser,String collection){
    try{
      firebaseFireStore.collection(collection).doc(appUser.appUserId).set(appUser.toJson());
    }catch(e){
      print('Exception $e');
    }
  }


  /// Get user
  ///
  Future<AppUser> getUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot = await firebaseFireStore.collection('AppUser').doc(id).get();
      print('Current app User Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getUser $e');
      return AppUser();
    }
  }

  ///
  ///
  Future<List<AppUser>> getAllAppUser(String getCollection) async{


    final List<AppUser> appUserList = [];
    final locateUser = locator<AuthServices>();
    try{
      QuerySnapshot snapshot = await firebaseFireStore.collection(getCollection).where(
        "userName",isNotEqualTo: locateUser.appUser.userName).get();

        print("Here is  your of current username==============="+"${locator<AuthServices>().appUser.userName}");
          // .where("userEmail",
          // isNotEqualTo:FireAuthService().appUser.userEmail).get();
          // locator<AuthServices>()
          // .appUser.userEmail).get();
      if(snapshot.docs.length > 0){
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      }
      else{
        print("No data found");
      }
    }catch(e){
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }



  ///Update user

  updateUserProfile(AppUser appUser) async{
    try{
      await firebaseFireStore.collection('AppUser').doc(appUser.appUserId).update(appUser.toJson());
    }catch(e){
      print('Exception@UpdateUserProfile=>$e');
    }
  }

  ///====================================///
  ///============== chat ===============///
  ///===================================///

  addUserMessage(AppUser currentAppUser,String toUserId,Conversation conversation, AppUser toAppUser) async{
    try{
      // await firebaseFireStore.collection("Conversations").doc("$fromUserId").set(appUser.toJson());
      // await firebaseFireStore.collection("Conversations").doc("$fromUserId$toUserId").collection("Messages").add(conversation.toJson());
      ///
      /// From User message
      ///
      await firebaseFireStore.collection("Conversations").doc("${currentAppUser.appUserId}").collection("Chats").doc("$toUserId").collection("messages").add(conversation.toJson());
      await firebaseFireStore.collection("Conversations").doc("${currentAppUser.appUserId}").collection("Chats").doc("$toUserId").set(toAppUser.toJson());
      ///
      /// to user message
      ///
      await firebaseFireStore.collection("Conversations").doc("$toUserId").collection("Chats").doc("${currentAppUser.appUserId}").collection("messages").add(conversation.toJson());
      await firebaseFireStore.collection("Conversations").doc("$toUserId").collection("Chats").doc("${currentAppUser.appUserId}").set(currentAppUser.toJson());
    }catch(e){
      print('Exception@sentUserMessage$e');
    }
  }

  ///
  /// Get conversation users list
  ///
  Stream<QuerySnapshot>? getUserConversationList(AppUser appUser) {
    try{
      Stream<QuerySnapshot> snapshot = firebaseFireStore.collection("Conversations").doc(appUser.appUserId).collection("Chats").orderBy('lastMessageAt',descending: false).snapshots();
      return snapshot;
    }catch(e){
      print('Exception@GetUserConversationList$e');
      return null;
    }
  }



  // addNominationData(AppUser appUser,NominateUsers nominateUsers,String collection){
  //   final locateUser = locator<AuthServices>();
  //   try{
  //     firebaseFireStore.collection(collection).doc(locateUser.appUser.appUserId).set(nominateUsers.toJson());
  //   }catch(e){
  //     print('Exception $e');
  //   }
  // }





/// liking and unliking updation
//
//   likingAndUnliking(String docsId,bool getLike)
//   {
//     _firestore.collection("NominationData").doc(AuthServices().authInstant.currentUser!.uid).collection("postData").doc(docsId).update(
//       {
//         'isLike':getLike,
//       }
//     );
//   }


  /// Pending Post Data
  static Future<void> pendingPostData({
    int? totalComments,
    String? ownerID,
    String? approval,
    String? nominationStatus,
    String? sendTo,
    String? imageUrl,
    String? nominateName,
    String? nominateEmail,
    String? nominateDis,
  }) async {
    DocumentReference documentReferencer = _firestore.collection('PendingPostData').doc(AuthServices().authInstant.currentUser!.uid).collection('pData').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "totalComments":totalComments,
      "ownerId":ownerID,
      "approval":approval,
      "nominationStatus":nominationStatus,
      "sendTo":sendTo,
      "imageUrl":imageUrl,
      "nominateName": nominateName,
      "nominateEmail": nominateEmail,
      "nominateDis": nominateDis,
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }



/// nomination data saving
  static Future<void> addNominateData({
    int? totalComments,
    String? ownerID,
    String? approval,
    String? nominationStatus,
    String? sendTo,
    String? imageUrl,
    String? nominateName,
    String? nominateEmail,
    String? nominateDis,
  }) async {
    DocumentReference documentReferencer = _firestore.collection('NominationData').doc(ownerID).collection('postData').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "totalComments":totalComments,
      "ownerId":ownerID,
      "approval":approval,
      "nominationStatus":nominationStatus,
      "sendTo":sendTo,
      "imageUrl":imageUrl,
      "nominateName": nominateName,
      "nominateEmail": nominateEmail,
      "nominateDis": nominateDis,
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }


  ///  update nominations Data
  ///
  ///


  void updateNominationData(String docId,String userID,String getNominationStatus) async {

    print("doc id:====="+docId);

    firebaseFireStore.collection("PendingPostData").doc(userID).collection("pData").doc(docId).update(
        {
          'approval':"Yes",
          'nominationStatus':getNominationStatus
        }
    );

  }

  /// comments on post
  Future<void> addComments(String comments,String docsID,String? userID,String? imageUrl,String? userName)
  async {
    try{
      DocumentReference documentReferencer = firebaseFireStore.collection('Comments').doc(docsID).collection("AllComments").doc();
      Map<String, dynamic> data = <String, dynamic>{
        'comments':comments,
        'userID':userID,
        'imageUrl':imageUrl,
        'userName':userName
      };
      await documentReferencer.set(
        data
      );
    }catch(e){
      print('Exception@UpdateUserProfile=>$e');
    }

  }
  /// Count comments
  ///
  ///

  void countDocuments(String docId,String ownerID) async {

    QuerySnapshot _myDoc = await firebaseFireStore.collection("Comments").doc(docId).collection("AllComments").get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;

      firebaseFireStore.collection("NominationData").doc(ownerID).collection("postData").doc(docId).update(
          {
            'totalComments':_myDocCount.length,
          }
      );

    // Count of Documents in Collection
  }
  // /// Liking and liking posts
  //
  // Future<void> likingPost(int index,bool like,String docsID,String? userID,String? imageUrl,String? userName)
  // async {
  //   try {
  //     DocumentReference documentReferencer = firebaseFireStore.collection(
  //         'Likes').doc(userID).collection("AllLikes").doc(docsID);
  //     Map<String, dynamic> data = <String, dynamic>{
  //       'index': index,
  //       'like': like,
  //       'docsID':docsID,
  //       'userID': userID,
  //       'imageUrl': imageUrl,
  //       'userName': userName
  //     };
  //     await documentReferencer.set(
  //         data
  //     );
  //   } catch (e) {
  //     print('Exception@UpdateUserProfile=>$e');
  //   }
  // }


  //
  // }
  //
  // Future<String> checkThis(String userId,String docID)
  // async {
  //
  //   var getback = "Hello";
  //   firebaseFireStore.collection("Likes").doc(userId).collection("AllLikes").doc(docID).get().then((value)
  //   {
  //
  //
  //     getback = value.data()?['userName'];
  //
  //     print("Here is get Back"+getback);
  //
  //     print("Here is the Like => "+"${value.data()?['like']}");
  //     print("Here is the User => "+"${value.data()?['userName']}");
  //
  //
  //     // print("what the fuck data:"+ value.data());
  //     // print(value.data(as dynamic ['like']);
  //
  //   });
  //
  //   return getback;
  //
  // }



  // List getList =[];
  // bool getLike= false;
  // bool likeChecking(String ownerId,String docsId,String userId)
  // {
  //   try{
  //     firebaseFireStore.collection("NominationData").doc(ownerId).collection("postData").doc(docsId).get().then((value)
  //     {
  //       print("Here is the value of likes => "+"${value.data()?['likes']}");
  //       getList = value.data()?['likes'];
  //       if(getList.contains(userId))
  //       {
  //         print("contain function checking =====================");
  //         // isLike = true;
  //         getLike = !getLike;
  //
  //         print("here is the value of gelike=>"+"$getLike");
  //       }
  //       return getLike;
  //     });
  //   }catch(e){
  //     print("here is e +"+"$e");
  //   }
  //
  //   return getLike;
  // }


// Future<bool> getLikeFun()
// async {
//   try{
//     QuerySnapshot snapshot = await firebaseFireStore.collection('NominationData').doc('owner').collection('AllLikes').where(
//         "like",isEqualTo: false).get();
//
//     print("Here is  your of current username==============="+"${locator<AuthServices>().appUser.userName}");
//     // .where("userEmail",
//     // isNotEqualTo:FireAuthService().appUser.userEmail).get();
//     // locator<AuthServices>()
//     // .appUser.userEmail).get();
//     if(snapshot.docs.length > 0){
//       snapshot.docs.forEach((element) {
//         appUserList.add(AppUser.fromJson(element, element.id));
//         print("getUser => ${element['userName']}");
//       });
//     }
//     else{
//       print("No data found");
//     }
//   }catch(e){
//     print('Exception @DatabaseService/GetAllUsers $e');
//   }
//
//   return true;
// }



/// opportunities submition
///



  static Future<void> submitOpportunity({
    String? opportunityOwner,
    String? titleOpportunities,
    String? organizationRequesting,
    String? description,
    String? selectDate,
    String? startTime,
    String? endTime ,
    String? addressOne,
    String? addressTwo ,
    String? cityName,
    String? stateName ,
    String? zipCode ,
    String? personalVehicle,
    String? tenagerAndParent,
  }) async {
    DocumentReference documentReferencer = _firestore.collection('SubmitOpportunities').doc(AuthServices().authInstant.currentUser!.uid).collection('AllOpportunities').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "opportunityOwner":opportunityOwner,
      "titleOpportunities":titleOpportunities,
      "organizationRequesting":organizationRequesting,
      "description": description,
      "selectDate": selectDate,
      "startTime": startTime,
      "endTime":endTime,
      "addressOne":addressOne,
      "addressTwo":addressTwo,
      "cityName":cityName,
      "stateName":stateName,
      "zipCode":zipCode,
      "personalVehicle":personalVehicle,
      "tenagerAndParent":tenagerAndParent,
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }


// /

void sendFriendRequest()
{
  firebaseFireStore.collection("Friends").doc(AuthServices().authInstant.currentUser!.uid).set(
    {
      "userId":AuthServices().authInstant.currentUser!.uid,
    }
  );
}

/// Pending Request
///

 void pendingRequest(String getUserId)
 {
   firebaseFireStore.collection("Requests").doc(getUserId).set(
       {
         "userId":AuthServices().authInstant.currentUser!.uid,
         "request approval": false,
         "sentTo": getUserId,
       }
   );
 }
 
 void deletePendingPosts({String? ownerID,String? docId})
 {
   firebaseFireStore.collection("PendingPostData").doc(ownerID).collection("pData").doc(docId).delete();
 }




}