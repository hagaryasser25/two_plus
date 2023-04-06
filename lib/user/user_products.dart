import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:two_plus/models/products_model.dart';
import 'package:two_plus/models/request_model.dart';
import 'package:two_plus/store/add_product.dart';
import 'package:two_plus/store/store-prices.dart';
import 'package:two_plus/user/user_prices.dart';

class UserProducts extends StatefulWidget {
  String name;
  static const routeName = '/userProducts';
  UserProducts({required this.name});

  @override
  State<UserProducts> createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;

  List<Products> productList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchProducts();
  }

  @override
  void fetchProducts() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("products").child('${widget.name}');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Products p = Products.fromJson(event.snapshot.value);
      productList.add(p);
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
                title: Center(child: Text('المنتجات'))),
            body: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          child: StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                              bottom: 15.h,
                            ),
                            crossAxisCount: 6,
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.w, left: 10.w),
                                      child: Center(
                                        child: Column(children: [
                                          Image.network(
                                              '${productList[index].imageUrl}',
                                              height: 100.h),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${productList[index].name}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${productList[index].space} GB',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          RatingBar.builder(
                                            initialRating: productList[index]
                                                .rating!
                                                .toDouble(),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 18,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate:
                                                (double rating2) async {
                                              rating2.toDouble();
                                              User? user = FirebaseAuth
                                                  .instance.currentUser;

                                              if (user != null) {
                                                String uid = user.uid;
                                                int date = DateTime.now()
                                                    .millisecondsSinceEpoch;

                                                DatabaseReference companyRef =
                                                    FirebaseDatabase.instance
                                                        .reference()
                                                        .child('products')
                                                        .child('${widget.name}')
                                                        .child(
                                                            productList[index]
                                                                .id
                                                                .toString());

                                                await companyRef.update({
                                                  'rating': rating2.toInt(),
                                                });
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 100.w, height: 35.h),
                                            child: ElevatedButton(
                                              child: Text('الأسعار'),
                                              onPressed: () async {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return UserPrices(
                                                    storeName: '${widget.name}',
                                                    productName:
                                                        '${productList[index].name}',
                                                    imageUrl:
                                                        '${productList[index].imageUrl}',
                                                  );
                                                }));
                                              },
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(
                                    3, index.isEven ? 3 : 3),
                            mainAxisSpacing: 50.0.h,
                            crossAxisSpacing: 5.0.w,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
