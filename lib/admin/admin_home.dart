import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:two_plus/admin/add_store.dart';
import 'package:two_plus/admin/admin_complains.dart';
import 'package:two_plus/admin/admin_offers.dart';
import 'package:two_plus/admin/admin_stores.dart';
import 'package:two_plus/admin/admin_subscription.dart';
import 'package:two_plus/auth/login_page.dart';
import 'package:two_plus/auth/splash_screen.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 243, 90, 79),
              title: Center(child: Text('الصفحة الرئيسية')),
               actions: [
              IconButton(
                color: Colors.white,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('تأكيد'),
                          content: Text('هل انت متأكد من تسجيل الخروج'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushNamed(
                                    context, SplashScreen.routeName);
                              },
                              child: Text('نعم'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('لا'),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.logout),
              ),
            ],
              
              ),
          body: Column(
            children: [
              Image.asset('assets/images/admin.png'),
              SizedBox(height: 20.h),
              Text('الخدمات المتاحة',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                         Navigator.pushNamed(context, AdminStores.routeName);
                      },
                      child: card('#ff5a4e', 'أضافة متجر')),
                  InkWell(
                      onTap: () {
                         Navigator.pushNamed(context,AdminOffers.routeName);
                      },
                      child: card('#ea9999', 'أضافة عرض')),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                         Navigator.pushNamed(context, AdminSubscription.routeName);
                      },
                      child: card('#ea9999', 'اشتراكات المتاجر')),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AdminComplains.routeName);
                      },
                      child: card('#ff5a4e', 'الشكاوى')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget card(String color, String text) {
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      color: HexColor(color),
      child: SizedBox(
        width: 177.w,
        height: 100.h,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          child: Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.white),
              SizedBox(width: 10.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
