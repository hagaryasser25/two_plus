import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:two_plus/user/user_home.dart';
import 'package:two_plus/user/user_products.dart';

import '../models/store_model.dart';

class StoreDetails extends StatefulWidget {
  String imageUrl;
  String name;
  String number;
  static const routeName = '/storeDetails';
  StoreDetails(
      {required this.imageUrl, required this.name, required this.number});

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          backgroundColor: HexColor('#f4cccc'),
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 243, 90, 79),
              title: Center(child: Text('تفاصيل المتجر'))),
          body: Column(
            children: [
              Card(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network('${widget.imageUrl}'),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '${widget.name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 120.h,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 30.w),
                            Text('رقم الهاتف : ${widget.number}'),
                            SizedBox(
                              width: 70.w,
                            ),
                            Image.asset(
                              'assets/images/phone.png',
                              height: 100.h,
                              width: 100.w,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 150, height: 40.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 243, 90, 79)),
                  onPressed: () async {
                    User? user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      String uid = user.uid;

                      DatabaseReference companyRef = FirebaseDatabase.instance
                          .reference()
                          .child('favourite')
                          .child(uid);

                      String? id = companyRef.push().key;

                      await companyRef.child(id!).set({
                        'id': id,
                        'name': widget.name,
                        'imageUrl': widget.imageUrl,
                        'phoneNumber': widget.number.toString(),
                      });
                    }

                    showAlertDialog(context);
                  },
                  child: Text("أضافة الى المفضلة"),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 150, height: 40.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserProducts(
                        name: '${widget.name}',
                      );
                    }));
                  },
                  child: Text("المنتجات"),
                ),
              ),
            ],
          ),
        ),
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
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم الأضافة الى المفضلة"),
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
