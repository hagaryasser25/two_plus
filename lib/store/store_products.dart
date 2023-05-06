import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:two_plus/models/products_model.dart';
import 'package:two_plus/models/request_model.dart';
import 'package:two_plus/store/add_product.dart';
import 'package:two_plus/store/store-prices.dart';

class StoreProducts extends StatefulWidget {
  String isSubscribe;
  String name;
  static const routeName = '/storeProducts';
  StoreProducts({required this.isSubscribe, required this.name});

  @override
  State<StoreProducts> createState() => _StoreProductsState();
}

class _StoreProductsState extends State<StoreProducts> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Request currentStore;

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
        .child("requests")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentStore = Request.fromSnapshot(snapshot);
      print(currentStore.offer);
    });
  }

  List<Products> productList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchProducts();
  }


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
              title: widget.isSubscribe == 'false'
                  ? Center(child: Text('المنتجات'))
                  : Align(
                      alignment: Alignment.topRight,
                      child: TextButton.icon(
                        // Your icon here
                        label: Text(
                          "أضافة منتج",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        icon: Align(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )), // Your text here
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddProduct(
                              name: '${currentStore.name}',
                              phoneNumber: '${currentStore.phoneNumber}',
                              offer: currentStore.offer!.toInt(),
                              currentNumber:
                                  currentStore.currentNumber!.toInt(),
                            );
                          }));
                        },
                      )),
            ),
            body: widget.isSubscribe == 'false'
                ? Center(
                    child: Text(
                        'لم يتم الأشتراك بعد فى أى عروض لذا لا يمكنك اضافة منتجات'))
                : Column(
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
                                            borderRadius:
                                                BorderRadius.circular(15.0),
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      BoxConstraints.tightFor(
                                                          width: 100.w,
                                                          height: 35.h),
                                                  child: ElevatedButton(
                                                    child: Text('المواصفات'),
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: Text('مواصفات الهاتف',textAlign: TextAlign.right,),
                                                          content: SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                Text('المساحة : ${productList[index].space}',textAlign: TextAlign.right,),
                                                                Text('مساحة الرامات : ${productList[index].ram}',textAlign: TextAlign.right),
                                                                Text('الألوان المتوفرة: ${productList[index].color}',textAlign: TextAlign.right),
                                                                Text('التفاصيل : ${productList[index].details}',textAlign: TextAlign.right),
                                                                
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'حسنا'))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      BoxConstraints.tightFor(
                                                          width: 100.w,
                                                          height: 35.h),
                                                  child: ElevatedButton(
                                                    child: Text('الأسعار'),
                                                    onPressed: () async {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return StorePrices(
                                                          storeName:
                                                              '${widget.name}',
                                                          productName:
                                                              '${productList[index].name}',
                                                          imageUrl:
                                                              '${productList[index].imageUrl}',
                                                        );
                                                      }));
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
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
                                                        .child('products')
                                                        .child('${widget.name}')
                                                        .child(
                                                            '${productList[index].id}')
                                                        .remove();
                                                    User? user = FirebaseAuth
                                                        .instance.currentUser;
                                                    if (user != null) {
                                                      String uid = user.uid;

                                                      DatabaseReference
                                                          companyRef =
                                                          FirebaseDatabase
                                                              .instance
                                                              .reference()
                                                              .child('products')
                                                              .child(
                                                                  '${widget.name}');

                                                      String? id =
                                                          companyRef.push().key;

                                                      DatabaseReference
                                                          storeRef =
                                                          FirebaseDatabase
                                                              .instance
                                                              .reference()
                                                              .child('requests')
                                                              .child(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid);

                                                      await storeRef.update({
                                                        'currentNumber':
                                                            (currentStore
                                                                    .currentNumber!) -
                                                                1,
                                                      });
                                                    }
                                                  },
                                                  child: Icon(Icons.delete,
                                                      color: Color.fromARGB(
                                                          255, 122, 122, 122)),
                                                )
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
