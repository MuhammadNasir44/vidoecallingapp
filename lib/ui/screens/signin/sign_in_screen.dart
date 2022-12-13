
// import 'package:agapeacts/ui/screens/widgets/custome_button.dart';
import 'package:chat_call_feature/core/enums/view_state.dart';
import 'package:chat_call_feature/core/utils/validator.dart';
import 'package:chat_call_feature/ui/screens/signin/signin_provider.dart';
import 'package:chat_call_feature/ui/screens/signup/signup_screen.dart';
import 'package:chat_call_feature/widgets/custom_textfeild.dart';
import 'package:chat_call_feature/widgets/custome_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (ctx, model, child) {
          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall:model.state == ViewState.busy,
                opacity: 0.5,
                progressIndicator: CircularProgressIndicator(
                  color: Colors.red,
                ),

              child: LayoutBuilder(
                    builder: (context, constraint) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraint
                              .maxHeight),
                          child: IntrinsicHeight(
                            child: Form(
                              key:model.formKey,
                              child: Column(
                                children: [
                                  // LogoAndSlogan(),
                                  SizedBox(height: 50.h,),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffF5F7F9),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      margin: EdgeInsets.only(
                                          left: 15.h, right: 15.h),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            'Login',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),

                                          //Email textfield

                                          CustomTextField(
                                            preFixIcon: 'assets/icons/emailid.svg',
                                            obsecure: false,
                                            lableText: 'Email id',
                                            hintText: '',
                                            textInputAction: TextInputAction.next,
                                            keyBoardType: TextInputType.emailAddress,
                                            onChanged: (value) {
                                              model.appUser.userEmail = value;
                                            },
                                            validator: Validator.validateName(name: model.appUser.userName),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),

                                          // password Textfield

                                          CustomTextField(
                                            preFixIcon: 'assets/icons/lock.svg',
                                            obsecure: true,
                                            hintText: '',
                                            lableText: 'Password',
                                            textInputAction: TextInputAction.next,
                                            keyBoardType: TextInputType.text,
                                            onChanged: (value) {
                                              model.appUser.password = value;
                                            },
                                            validator: Validator.validatePassword(password: model.appUser.password),
                                          ),

                                          SizedBox(
                                            height: 10.h,
                                          ),

                                          Row(
                                            children: [
                                              Expanded(child: SizedBox()),
                                              Container(
                                                child: Text(
                                                  'Forgot Password?',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Expanded(
                                              child: SizedBox(
                                                height: 30.h,
                                              )),

                                          CustomButton(

                                              onPressed: () => model.checkUserTextField(
                                                  model.appUser, ctx),


                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             IntroScreens()));

                                            title: 'Login',
                                          ),

                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child: Center(
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: 'Don\'t have an account?',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.sp,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: ' Sign up',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 15.sp,
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontFamily: 'Roboto',
                                                              decoration:
                                                              TextDecoration
                                                                  .underline,
                                                            ),
                                                            recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (
                                                                            context) =>
                                                                            SignUpScreen()));
                                                                // navigate to desired screen
                                                              })
                                                      ]),
                                                ),
                                              )),

                                          Expanded(
                                              child: SizedBox(
                                                height: 15.h,
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            ),
          );
        },
      ),
    );
  }
}
