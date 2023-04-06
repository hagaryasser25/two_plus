import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/complains_model.dart';
import 'admin_replay.dart';

class AdminComplains extends StatefulWidget {
  static const routeName = '/adminComplains';
  const AdminComplains({super.key});

  @override
  State<AdminComplains> createState() => _AdminComplainsState();
}

class _AdminComplainsState extends State<AdminComplains> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Complains> complainsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchComplains();
  }

  @override
  void fetchComplains() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("userComplains");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Complains p = Complains.fromJson(event.snapshot.value);
      complainsList.add(p);
      keyslist.add(event.snapshot.key.toString());
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
                    title: Center(child: Text('الشكاوى'))),
                body: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemCount: complainsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        right: 15,
                                        left: 15,
                                        bottom: 10),
                                    child: Column(children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'اسم المشتكى : ${complainsList[index].name.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'رقم الهاتف: ${complainsList[index].phoneNumber.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 120.w, height: 35.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 243, 90, 79),
                                          ),
                                          child: Text('تفاصيل الشكوى'),
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  'الشكوى',
                                                  textAlign: TextAlign.right,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '${complainsList[index].description.toString()}',
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            width: 120.w,
                                                            height: 35.h),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Color.fromARGB(
                                                            255, 243, 90, 79),
                                                      ),
                                                      child: Text(
                                                          'الرد على الشكوى'),
                                                      onPressed: () async {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return AdminReplay(
                                                            complain:
                                                                '${complainsList[index].description.toString()}',
                                                            uid:
                                                                '${complainsList[index].userUid.toString()}',
                                                          );
                                                        }));
                                                      },
                                                    ),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            width: 120.w,
                                                            height: 35.h),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Color.fromARGB(
                                                            255, 243, 90, 79),
                                                      ),
                                                      child: Text('مسح الشكوى'),
                                                      onPressed: () async {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    super
                                                                        .widget));
                                                        base
                                                            .child(
                                                                complainsList[
                                                                        index]
                                                                    .id
                                                                    .toString())
                                                            .remove();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 50.w,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
