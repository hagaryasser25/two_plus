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
import 'package:two_plus/admin/add_store.dart';
import 'package:two_plus/models/store_model.dart';

class AdminStores extends StatefulWidget {
  static const routeName = '/adminStores';
  const AdminStores({super.key});

  @override
  State<AdminStores> createState() => _AdminStoresState();
}

class _AdminStoresState extends State<AdminStores> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Store> storesList = [];
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
    base = database.reference().child("stores");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Store p = Store.fromJson(event.snapshot.value);
      storesList.add(p);
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
              title: Center(child: Text('المتاجر'))),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddStore.routeName);
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, // circular shape
                  color: Color.fromARGB(255, 243, 90, 79)),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
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
                                  /*
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        
                                    return PlaceDetails(
                                      name:
                                          '${placesList[index].name.toString()}',
                                      price:
                                          '${placesList[index].price.toString()}',
                                      governorate:
                                          '${placesList[index].governorate.toString()}',
                                      address:
                                          '${placesList[index].address.toString()}',
                                      history:
                                          '${placesList[index].history.toString()}',
                                      latitude:
                                          '${placesList[index].latitude.toString()}',
                                      longitude:
                                          '${placesList[index].longitude.toString()}',
                                      imageUrl:
                                          '${placesList[index].imageUrl.toString()}',
                                    );
                                    
                                  }));
                                  */
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.white,
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
                                                      BorderRadius.circular(15.0),
                                                  child: Image.network(
                                                      '${storesList[index].imageUrl.toString()}'),
                                                ),
                                              ),
                                              Text(
                                                '${storesList[index].name.toString()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Cairo',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                               Text(
                                                'البريد الألكترونى : ${storesList[index].email.toString()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Cairo',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                               Text(
                                                'كلمة المرور : ${storesList[index].password.toString()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Cairo',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                               Text(
                                                'رقم الهاتف : ${storesList[index].phoneNumber.toString()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Cairo',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              InkWell(
                                              onTap: () async {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            super.widget));
                                                FirebaseDatabase.instance
                                                    .reference()
                                                    .child('stores')
                                                    .child(
                                                        '${storesList[index].uid}')
                                                    .remove();
                                              },
                                              child: Icon(Icons.delete,
                                                  color: Colors.black,),
                                            )
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
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
