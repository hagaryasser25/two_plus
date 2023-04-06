import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_plus/store/store_replays.dart';
import 'package:two_plus/user/store_details.dart';

import '../auth/login_page.dart';
import '../models/store_model.dart';
import '../store/send_complain.dart';

class UserFavourite extends StatefulWidget {
  static const routeName = '/userFavourite';
  const UserFavourite({super.key});

  @override
  State<UserFavourite> createState() => _UserFavouriteState();
}

class _UserFavouriteState extends State<UserFavourite> {
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

  @override
  void fetchStores() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("favourite")
        .child(FirebaseAuth.instance.currentUser!.uid);
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
              title: Center(child: Text('المفضبة'))),
          body: Column(
            children: [
              SizedBox(
                height: 10.h,
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
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 150, height: 40.h),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue),
                                  onPressed: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                super.widget));
                                    base
                                        .child(storesList[index].id.toString())
                                        .remove();
                                  },
                                  child: Text("أزالة من المفضلة"),
                                ),
                              ),
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
