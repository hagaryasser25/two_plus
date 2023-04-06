import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:two_plus/admin/add_store.dart';
import 'package:two_plus/admin/admin_offers.dart';
import 'package:two_plus/admin/admin_stores.dart';
import 'package:two_plus/auth/login_page.dart';
import 'package:two_plus/auth/splash_screen.dart';
import 'package:two_plus/store/send_complain.dart';
import 'package:two_plus/store/store_offers.dart';
import 'package:two_plus/store/store_products.dart';
import 'package:two_plus/store/store_replays.dart';
import 'package:two_plus/store/store_subscription.dart';

import '../models/get_store_model.dart';

class StoreHome extends StatefulWidget {
  static const routeName = '/storeHome';
  const StoreHome({super.key});

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Stores currentStore;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("stores")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentStore = Stores.fromSnapshot(snapshot);
      print(currentStore.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 243, 90, 79),
              title: Center(child: Text('الصفحة الرئيسية'))),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 200.h,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 90, 79),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, UserSubscription.routeName);
                          },
                          title: Text('اشتراكاتى'),
                          leading: Icon(Icons.book),
                        ))),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, SendComplain.routeName);
                          },
                          title: Text('ارسال شكوى'),
                          leading: Icon(Icons.ads_click),
                        ))),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, StoreReplays.routeName);
                          },
                          title: Text('الردود على الشكاوى'),
                          leading: Icon(Icons.app_registration),
                        ))),
                Divider(
                  thickness: 0.8,
                  color: Colors.grey,
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
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
                          title: Text('تسجيل الخروج'),
                          leading: Icon(Icons.exit_to_app_rounded),
                        )))
              ],
            ),
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
                        Navigator.pushNamed(context, StoreOffers.routeName);
                      },
                      child: card('#ff5a4e', 'الأشتراك فى عرض')),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return StoreProducts(
                            isSubscribe: '${currentStore.isSubscribe}',
                            name: '${currentStore.fullName}',
                          );
                        }));
                      },
                      child: card('#ea9999', 'أضافة منتج')),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: InkWell(
                    onTap: () {
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
                    child: card('#ff5a4e', 'تسجيل الخروج')),
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
              SizedBox(width: 8.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
