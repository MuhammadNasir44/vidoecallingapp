



import 'package:chat_call_feature/core/enums/view_state.dart';
import 'package:chat_call_feature/core/models/app_user.dart';
import 'package:chat_call_feature/core/models/custom_auth_result.dart';
import 'package:chat_call_feature/core/services/auth_services.dart';
import 'package:chat_call_feature/core/services/locator.dart';
import 'package:chat_call_feature/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';



class SignUpProvider extends BaseViewModal{

  // final authServices = AuthServices();
  final _authServices = locator<AuthServices>();
  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();
  final formKey = GlobalKey<FormState>();
  bool isAgreeTermsAndConditions = false;
  bool isVisiblePassword = true;
  ///
  /// Visible Password
  ///
  visiblePassword(){
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  termsAndConditions(value)
  {
    isAgreeTermsAndConditions = value;
    print("Terms and conditions $isAgreeTermsAndConditions");
    notifyListeners();
  }


  ///
  /// Sign Up user
  ///
  signUpUser(AppUser appUser, BuildContext context) async{
    if(formKey.currentState!.validate())
    {

      // sign up user
      if(true){
        print("User Name: ${appUser.userName}");
        print("User Email: ${appUser.userEmail}");
        print("User Password: ${appUser.password}");
        print("User ConfirmPassword: ${appUser.confirmPassword}");
        appUser.isFirstLogin = true;
        setState(ViewState.busy);
        appUser.createdAt = DateTime.now().toString();
        // appUser.lastMessageAt = DateTime.now();
        customAuthResult = await _authServices.signUpUser(appUser);
        setState(ViewState.idle);
        if(customAuthResult.user != null) {
          print("SignUpUserId=> ${_authServices.appUser.appUserId}");
          // Navigator.pushReplacement(
          //     context, CustomPageRoute(child: IntroScreens()));
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
      }else{
        print('pou must agree to Terms and Conditions');
        // showSnackBar(context, "You must agree to Terms and Conditions");
      }
      // Get.offAll(()=>WalkThroughScreen());
    }
  }


}