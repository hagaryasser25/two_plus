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
import 'package:two_plus/store/subscribe_form.dart';

import '../models/get_store_model.dart';

class StoreOffers extends StatefulWidget {
  static const routeName = '/storeOffers';
  const StoreOffers({super.key});

  @override
  State<StoreOffers> createState() => _StoreOffersState();
}

class _StoreOffersState extends State<StoreOffers> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Offer> offerList = [];
  List<String> keyslist = [];
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchOffers();
  }

  @override
  void fetchOffers() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("offers");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Offer p = Offer.fromJson(event.snapshot.value);
      offerList.add(p);
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
              title: Center(child: Text('العروض'))),
          body: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              right: 10.w,
              left: 10.w,
            ),
            child: ListView.builder(
              itemCount: offerList.length,
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
                                      'اسم العرض: ${offerList[index].name.toString()} منتج',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'السعر : ${offerList[index].price.toString()} جنيه فى الشهر',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'الوصف : ${offerList[index].description.toString()}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tightFor(
                                        width: 100.w, height: 50.h),
                                    child: ElevatedButton(
                                      child: Text('اشتراك الأن'),
                                      onPressed: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return SubscribeForm(
                                            name: '${currentStore.fullName}',
                                            phoneNumber: '${currentStore.phoneNumber}',
                                            offer: '${offerList[index].name}',

                                          );
                                        }));
                                      },
                                    ),
                                  ),
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
