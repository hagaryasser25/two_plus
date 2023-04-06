import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../models/replays_model.dart';

class StoreReplays extends StatefulWidget {
  static const routeName = '/storeReplays';
  const StoreReplays({super.key});

  @override
  State<StoreReplays> createState() => _StoreReplaysState();
}

class _StoreReplaysState extends State<StoreReplays> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Replays> replaysList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchReplays();
  }

  @override
  void fetchReplays() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("adminReplays");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Replays p = Replays.fromJson(event.snapshot.value);
      replaysList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 243, 90, 79),
              title: Center(child: Text('الردود على الشكاوى'))),
          body: Column(
            children: [
              FutureBuilder(
                builder: ((context, snapshot) {
                  return Expanded(
                    flex: 8,
                    child: ListView.builder(
                      itemCount: replaysList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (FirebaseAuth.instance.currentUser!.uid ==
                            replaysList[index].userUid) {
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
                                            'الشكوى : ${replaysList[index].userComplain.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'الرد : ${replaysList[index].description.toString()}',
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
                                            primary: Color.fromARGB(255, 243, 90, 79),
                                          ),
                                          child: Text('مسح الشكوى'),
                                          onPressed: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            base
                                                .child(replaysList[index]
                                                    .id
                                                    .toString())
                                                .remove();
                                          },
                                        ),
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
                        } else {
                          return Text('');
                        }
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDate(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);

    return DateFormat('MMM dd yyyy').format(dateTime);
  }
}
