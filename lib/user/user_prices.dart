import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:two_plus/models/products_model.dart';
import 'package:two_plus/models/request_model.dart';
import 'package:two_plus/store/add_price.dart';
import 'package:two_plus/store/add_product.dart';

import '../models/prices_model.dart';
import 'dart:ui' as ui;

class UserPrices extends StatefulWidget {
  String storeName;
  String productName;
  String imageUrl;
  static const routeName = '/userPrices';
  UserPrices(
      {required this.storeName,
      required this.productName,
      required this.imageUrl});

  @override
  State<UserPrices> createState() => _UserPricesState();
}

class _UserPricesState extends State<UserPrices> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Request currentStore;
  List<Price> priceList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchPrices();
  }

  @override
  void fetchPrices() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("prices")
        .child('${widget.storeName}')
        .child('${widget.productName}');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Price p = Price.fromJson(event.snapshot.value);
      priceList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
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
              title: Center(child: Text('الأسعار'))),
          body: Container(
            child: ListView.builder(
              itemCount: priceList.length,
              itemBuilder: (BuildContext context, int index) {
                var date = priceList[index].date;
                return InkWell(
                  onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>saveastmara(CentersList[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 10, left: 10, bottom: 10, top: 20),
                    child: Container(
                      width: 350,
                      height: 100,
                      decoration: BoxDecoration(
                        color: HexColor('#ea9999'),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              width: 68,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                image: DecorationImage(
                                  image: NetworkImage('${widget.imageUrl}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              /* add child content here */
                            ),
                          ),
                          Column(
                            //  mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: new Text(
                                      'اليوم : ${getDate(date!)}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: new Text(
                                      'السعر : ${priceList[index].price.toString()}      ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
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
