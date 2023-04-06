import 'package:animated_flip_card/animated_flip_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:two_plus/admin/add_offer.dart';
import 'package:two_plus/admin/add_store.dart';
import 'package:two_plus/models/offer_model.dart';
import 'package:two_plus/models/store_model.dart';
import 'package:two_plus/models/subscription_model.dart';

class AdminSubscription extends StatefulWidget {
  static const routeName = '/adminSubscription';
  const AdminSubscription({super.key});

  @override
  State<AdminSubscription> createState() => _AdminSubscriptionState();
}

class _AdminSubscriptionState extends State<AdminSubscription> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Subscription> subscriptionList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchSubscriptions();
  }

  @override
  void fetchSubscriptions() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("requests");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Subscription p = Subscription.fromJson(event.snapshot.value);
      subscriptionList.add(p);
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
              title: Center(child: Text('اشتراكات المتاجر'))),
          body: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              right: 10.w,
              left: 10.w,
            ),
            child: ListView.builder(
              itemCount: subscriptionList.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        color: HexColor('#ea9999'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 15, left: 15, bottom: 10),
                            child: Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'اسم المتجر : ${subscriptionList[index].name.toString()}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'رقم الهاتف : ${subscriptionList[index].phoneNumber.toString()}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'اسم العرض : ${subscriptionList[index].offer.toString()} منتج',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'عدد الشهور : ${subscriptionList[index].month.toString()}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'حالة الطلب : ${subscriptionList[index].status.toString()}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  subscriptionList[index].status ==
                                          'فى انتظار الموافقة'
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ConstrainedBox(
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                      width: 120.w,
                                                      height: 35.h),
                                              child: ElevatedButton(
                                                child: Text('قبول الطلب'),
                                                onPressed: () async {
                                                  User? user = FirebaseAuth
                                                      .instance.currentUser;

                                                  if (user != null) {
                                                    String uid = user.uid;
                                                    int date = DateTime.now()
                                                        .millisecondsSinceEpoch;

                                                    DatabaseReference
                                                        companyRef =
                                                        FirebaseDatabase
                                                            .instance
                                                            .reference()
                                                            .child('requests')
                                                            .child(
                                                                '${subscriptionList[index].uid.toString()}');

                                                    await companyRef.update({
                                                      'status': 'تم قبول الطلب',
                                                    });

                                                    DatabaseReference storeRef =
                                                        FirebaseDatabase
                                                            .instance
                                                            .reference()
                                                            .child('stores')
                                                            .child(
                                                                '${subscriptionList[index].uid.toString()}');

                                                    await storeRef.update({
                                                      'isSubscribe': 'true',
                                                    });
                                                  }
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              super.widget));
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            ConstrainedBox(
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                      width: 120.w,
                                                      height: 35.h),
                                              child: ElevatedButton(
                                                child: Text('رفض الطلب'),
                                                onPressed: () async {
                                                  User? user = FirebaseAuth
                                                      .instance.currentUser;

                                                  if (user != null) {
                                                    String uid = user.uid;
                                                    int date = DateTime.now()
                                                        .millisecondsSinceEpoch;

                                                    DatabaseReference
                                                        companyRef =
                                                        FirebaseDatabase
                                                            .instance
                                                            .reference()
                                                            .child('requests')
                                                            .child(
                                                                '${subscriptionList[index].uid.toString()}');

                                                    await companyRef.update({
                                                      'status': 'تم رفض الطلب',
                                                    });
                                                  }
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              super.widget));
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            base
                                                .child(subscriptionList[index]
                                                    .uid
                                                    .toString())
                                                .remove();
                                          },
                                          child: Icon(Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 122, 122, 122)),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
