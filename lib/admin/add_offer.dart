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

class AddOffer extends StatefulWidget {
  static const routeName = '/addOffer';
 const AddOffer({super.key});

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
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
                            backgroundImage:
                                AssetImage('assets/images/offer.jfif'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        height: 65.h,
                        child: TextField(
                          style: TextStyle(color: Color.fromARGB(255, 243, 90, 79)),
                          controller: nameController,
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
                              borderSide:
                                  BorderSide(width: 1.0, color: Color.fromARGB(255, 243, 90, 79)),
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'الاسم',
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
                      SizedBox(
                        height: 65.h,
                        child: TextField(
                          style: TextStyle(color: Color.fromARGB(255, 243, 90, 79)),
                          controller: priceController,
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
                              borderSide:
                                  BorderSide(width: 1.0, color: Color.fromARGB(255, 243, 90, 79)),
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'السعر فى الشهر',
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
                      SizedBox(
                        height: 65.h,
                        child: TextField(
                          style: TextStyle(color: Color.fromARGB(255, 243, 90, 79)),
                          controller: descriptionController,
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
                              borderSide:
                                  BorderSide(width: 1.0, color: Color.fromARGB(255, 243, 90, 79)),
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'الوصف',
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
                          ),
                          onPressed: () async {
                            int name = int.parse(nameController.text);
                            String price =
                                priceController.text.trim();
                            String description = descriptionController.text.trim();

                            if (name == null ||
                                price.isEmpty ||
                                description.isEmpty ) {
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
                                  .child('offers');

                              String? id = companyRef.push().key;

                              await companyRef.child(id!).set({
                                'id': id,
                                'name': name,
                                'price': price,
                                'description': description,
                              });
                            }
                            showAlertDialog(context);
                          },
                          child: Text('أضافة',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
