



import 'package:chat_call_feature/core/enums/view_state.dart';
import 'package:chat_call_feature/core/models/app_user.dart';
import 'package:chat_call_feature/core/models/custom_auth_result.dart';
import 'package:chat_call_feature/core/services/auth_services.dart';
import 'package:chat_call_feature/core/services/locator.dart';
import 'package:chat_call_feature/core/view_models/base_view_model.dart';
import 'package:chat_call_feature/ui/screens/homepage.dart';
import 'package:chat_call_feature/ui/screens/messages/userslist.dart';
import 'package:chat_call_feature/widgets/custom_page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class LoginProvider extends BaseViewModal{

  final _authService = locator<AuthServices>();
  AppUser appUser = AppUser();
  CustomAuthResult customAuthResult = CustomAuthResult();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isVisiblePassword = true;
  bool isRememberMe = false;

  // LoginProvider(){
  //   isRememberMe = false;
  //   isVisiblePassword = true;
  // }

  rememberMe(value){
    isRememberMe = value;
    notifyListeners();
  }
  ///
  /// Visible Password
  ///
  visiblePassword(){
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword!;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  resetPassword()async{
    if(appUser.userEmail != null){
      print('Reset User password Email=>${appUser.userEmail}');
      await _authService.resetUserPassword(appUser.userEmail!);
    }
  }


  ///
  /// Login user
  ///
  checkUserTextField(AppUser appUser,BuildContext context)async{
    if(formKey.currentState!.validate()){
      print("App user email: ${appUser.userEmail}");
      print("App user Password: ${appUser.password}");
      setState(ViewState.busy);
      customAuthResult = await _authService.loginUser(appUser);

      setState(ViewState.idle);

      if(customAuthResult.user != null){
        print("App user Id: ${_authService.appUser.appUserId}");
        print("Is first Login=> ${_authService.appUser.isFirstLogin}");
        if(_authService.appUser.isFirstLogin == true){
          Navigator.pushReplacement(context, CustomPageRoute(child: UsersListView()));
        }
        else if(_authService.appUser.isFirstLogin == false){
          Navigator.pushReplacement(context, CustomPageRoute(child: UsersListView()));
        }

      }
      else{
        Get.defaultDialog(
          title: "Error Message",
          confirmTextColor: Colors.white,
          onConfirm: (){
            Navigator.pop(context);
          },
          content: Text(customAuthResult.errorMessage!),
        );
      }
      // Get.offAll(()=>WalkThroughScreen());
      // login
    }
  }

}