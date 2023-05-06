import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_plus/auth/splash_screen.dart';
import 'package:two_plus/store/store_replays.dart';
import 'package:two_plus/user/send_complain.dart';
import 'package:two_plus/user/store_details.dart';
import 'package:two_plus/user/user_favourite.dart';
import 'package:two_plus/user/user_phones.dart';

import '../auth/login_page.dart';
import '../models/store_model.dart';
import '../store/send_complain.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Store> storesList = [];
  List<Store> searchList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchStores();
  }

  void fetchStores() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("stores");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Store p = Store.fromJson(event.snapshot.value);
      storesList.add(p);
      searchList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
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
                                context, UserFavourite.routeName);
                          },
                          title: Text('المفضلة'),
                          leading: Icon(Icons.favorite),
                        ))),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, UserPhones.routeName);
                          },
                          title: Text('البحث عن الهواتف'),
                          leading: Icon(Icons.mobile_friendly),
                        ))),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, UserComplain.routeName);
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
                            Navigator.pushNamed(
                                context, StoreReplays.routeName);
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
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'بحث عن متجر',
                  ),
                  onChanged: (char) {
                    setState(() {
                      if (char.isEmpty) {
                        setState(() {
                          storesList = searchList;
                        });
                      } else {
                        storesList = [];
                        for (Store model in searchList) {
                          if (model.name!.contains(char)) {
                            storesList.add(model);
                          }
                        }
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Image.asset('assets/images/home.jpg', width: double.infinity),
              Container(
                child: Expanded(
                  flex: 8,
                  child: ListView.builder(
                      itemCount: storesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StoreDetails(
                                      imageUrl:
                                          storesList[index].imageUrl.toString(),
                                      name: storesList[index].name.toString(),
                                      number: storesList[index]
                                          .phoneNumber
                                          .toString(),
                                    );
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 5, bottom: 5),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5.w),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Image.network(
                                                      '${storesList[index].imageUrl.toString()}'),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${storesList[index].name.toString()}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
