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

class PhoneDetails extends StatefulWidget {
  String imageUrl;
  String name;
  String color;
  String details;
  String price1;
  String price2;
  String price3;
  String ram;
  String space;
  String store;
  static const routeName = '/phoneDetails';
  PhoneDetails(
      {required this.imageUrl,
      required this.name,
      required this.color,
      required this.details,
      required this.price1,
      required this.price2,
      required this.price3,
      required this.ram,
      required this.space,
      required this.store});

  @override
  State<PhoneDetails> createState() => _PhoneDetailsState();
}

class _PhoneDetailsState extends State<PhoneDetails> {
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
              title: Center(child: Text('نفاصيل المنتج'))),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
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
                                child: Image.network(
                                  '${widget.imageUrl}',
                                  height: 200.h,
                                ),
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
                              Text('اسم المتجر: ${widget.store}'),
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
                
                Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  child: Text('${widget.details}'),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w, left: 15.w),
                    child: Text('المساحة: ${widget.space} GB'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text('مساحة الرامات : ${widget.ram}')),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text('الألوان المتوفرة : ${widget.color}')),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text('السعر الأول: ${widget.price1}')),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text('السعر الثانى: ${widget.price2}')),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text('السعر الثالث: ${widget.price3}')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
