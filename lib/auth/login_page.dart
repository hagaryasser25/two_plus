import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';
import 'package:two_plus/auth/signup_page.dart';
import 'package:two_plus/auth/store_login.dart';

import '../user/user_home.dart';
import 'admin_login.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                              'تستطيع تسجيل الدخول من خلال هذه الشاشة',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              height: 65.h,
                              child: TextField(
                                style: TextStyle(
                                    color: Color.fromARGB(255, 243, 90, 79)),
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color.fromARGB(255, 243, 90, 79),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Color.fromARGB(255, 243, 90, 79),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        width: 1.0,
                                        color:
                                            Color.fromARGB(255, 243, 90, 79)),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'البريد الألكترونى',
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 243, 90, 79),
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              height: 65.h,
                              child: TextField(
                                style: TextStyle(
                                    color: Color.fromARGB(255, 243, 90, 79)),
                                controller: passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: Color.fromARGB(255, 243, 90, 79),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Color.fromARGB(255, 243, 90, 79),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        width: 1.0,
                                        color:
                                            Color.fromARGB(255, 243, 90, 79)),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'كلمة المرور',
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 243, 90, 79),
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 150.w, height: 50.h),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 243, 90, 79),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          25), // <-- Radius
                                    ),
                                  ),
                                  child: Text(
                                    'سجل دخول',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  onPressed: () async {
                                    var email = emailController.text.trim();
                                    var password =
                                        passwordController.text.trim();

                                    if (email.isEmpty || password.isEmpty) {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text(
                                                  "please fill all fields"))
                                          .show(context);

                                      return;
                                    }
                                    ProgressDialog progressDialog =
                                        ProgressDialog(context,
                                            title: Text('Logging In'),
                                            message: Text('Please Wait'));
                                    progressDialog.show();

                                    try {
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      UserCredential userCredential =
                                          await auth.signInWithEmailAndPassword(
                                              email: email, password: password);

                                      if (userCredential.user != null) {
                                        progressDialog.dismiss();
                                        Navigator.pushNamed(
                                            context, UserHome.routeName);
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      progressDialog.dismiss();
                                      if (e.code == 'user-not-found') {
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description:
                                                    Text("user not found"))
                                            .show(context);
                                        return;
                                      } else if (e.code == 'wrong-password') {
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description: Text(
                                                    "wrong email or password"))
                                            .show(context);

                                        return;
                                      }
                                    } catch (e) {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description:
                                                  Text("something went wrong"))
                                          .show(context);
                                      print(e);

                                      progressDialog.dismiss();
                                    }
                                  }),
                            ),
                            SizedBox(height: 20.h,),
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
