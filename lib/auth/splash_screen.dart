import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';
import 'package:two_plus/auth/login_page.dart';
import 'package:two_plus/auth/signup_page.dart';
import 'package:two_plus/auth/store_login.dart';

import '../user/user_home.dart';
import 'admin_login.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final passwordController = TextEditingController();

  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 250.h,
                    child: ClipPath(
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        color: Color.fromARGB(255, 243, 90, 79),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 65.h),
                          child: Text("Two Plus",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 29,
                                  fontWeight: FontWeight.w600)),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'اهلا بك فى تطبيق two plus',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 40.h),
                              SizedBox(
                              width: 150.w,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary:  HexColor('#ea9999'),
                                ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, LoginPage.routeName);
                                  },
                                  
                                  icon: const Icon(
                                      Icons.admin_panel_settings),
                                  label: const Text(
                                    "المستخدم",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                            SizedBox(
                              width: 150.w,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary:  HexColor('#ea9999'),
                                ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AdminLogin.routeName);
                                  },
                                  
                                  icon: const Icon(
                                      Icons.admin_panel_settings),
                                  label: const Text(
                                    "الأدمن",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                            SizedBox(width: 30.w,),
                            SizedBox(
                              width: 150.w,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary:  HexColor('#ea9999'),
                                ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, StoreLogin.routeName);
                                  },
                                 
                                  icon: const Icon(Icons.store),
                                  label: const Text(
                                    "المتجر",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                            SizedBox(
                              width: 150.w,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary:  HexColor('#ea9999'),
                                ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, SignupPage.routeName);
                                  },
                                  
                                  icon: const Icon(Icons.login),
                                  label: const Text(
                                    "انشاء حساب",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Positioned(
                top: 180.h,
                right: 130.w,
                child: Align(
                  alignment: Alignment(0, 0.000000),
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                      radius: 55,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
