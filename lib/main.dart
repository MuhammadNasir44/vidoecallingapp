
import 'package:chat_call_feature/ui/screens/messages/userslist.dart';
import 'package:chat_call_feature/ui/screens/signup/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'core/services/auth_services.dart';
import 'core/services/locator.dart';
import 'ui/screens/signin/signin_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (contex) => LoginProvider(),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: SplashScreen(),
        ),
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  final authService = locator<AuthServices>();

  splashScreenDelay() async {
    ///
    /// splash screen delay
    ///
    await Future.delayed(const Duration(seconds: 3));

    if(authService.appUser.isFirstLogin == true && authService.appUser.appUserId!=null)
    {
      Get.offAll(() => UsersListView());
    }
    else
    {
      Get.offAll(() => SignUpScreen());
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreenDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: Text("Messanger App"),
          )
        ],
      ),

    );
  }
}

