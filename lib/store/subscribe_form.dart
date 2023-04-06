import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:two_plus/admin/admin_home.dart';
import 'package:two_plus/models/store_model.dart';
import 'package:two_plus/store/store_home.dart';

class SubscribeForm extends StatefulWidget {
  String name;
  String phoneNumber;
  String offer;
  SubscribeForm({
    required this.name,
    required this.phoneNumber,
    required this.offer,
  });

  @override
  State<SubscribeForm> createState() => _SubscribeFormState();
}

class _SubscribeFormState extends State<SubscribeForm> {
  var monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            body: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
                left: 10.w,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/offer.jfif'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      style: TextStyle(color: Color.fromARGB(255, 243, 90, 79)),
                      controller: monthController,
                      decoration: InputDecoration(
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
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'عدد الشهور',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 243, 90, 79),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 243, 90, 79),
                          textStyle: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        String month = monthController.text.trim();
                        int currentNumber = 0;
                        int offer = int.parse(widget.offer);
                        String status = 'فى انتظار الموافقة';

                        if (month.isEmpty) {
                          CherryToast.info(
                            title: Text('ادخل جميع الحقول'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('requests');

                          String? id = companyRef.push().key;

                          await companyRef.child(uid).set({
                            'id': id,
                            'name': widget.name,
                            'uid': uid,
                            'phoneNumber': widget.phoneNumber,
                            'offer': offer,
                            'currentNumber': currentNumber.toInt(),
                            'month': month,
                            'status': status,
                          });
                        }
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('ادفع الأن'),
                                  content: Container(
                                    height: 100.h,
                                    child: Text('اختر طريقة الدفع'),
                                  ),
                                  actions: [
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.credit_card,
                                          size: 18),
                                      label: Text('بطاقة الأئتمان'),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Notice"),
                                              content: SizedBox(
                                                height: 65.h,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        HexColor('#155564'),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xfff8a55f),
                                                          width: 2.0),
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'ادخل رقم الفيزا',
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        HexColor('#6bbcba'),
                                                  ),
                                                  child: Text("دفع"),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        StoreHome.routeName);
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.credit_card,
                                          size: 18),
                                      label: Text('كاش'),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Notice"),
                                              content: Text(
                                                  "تم ارسال الطلب وسيتم التواصل معك فى اقرب وقت للتأكيد"),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        HexColor('#6bbcba'),
                                                  ),
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        StoreHome.routeName);
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ));
                      },
                      child:
                          Text('اشتراك', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة العرض"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
