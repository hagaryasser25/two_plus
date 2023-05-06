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
import 'package:two_plus/store/store_home.dart';

class AddPhone extends StatefulWidget {
  static const routeName = '/addProduct';
  const AddPhone({super.key});

  @override
  State<AddPhone> createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  var nameController = TextEditingController();
  var price1Controller = TextEditingController();
  var price2Controller = TextEditingController();
  var price3Controller = TextEditingController();
  var spaceController = TextEditingController();
  var colorController = TextEditingController();
  var ramController = TextEditingController();
  var detailsController = TextEditingController();
    var storeController = TextEditingController();

  String imageUrl = '';
  File? image;

  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

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
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Color.fromARGB(255, 235, 234, 234),
                              backgroundImage:
                                  image == null ? null : FileImage(image!),
                            )),
                        Positioned(
                            top: 120,
                            left: 120,
                            child: SizedBox(
                              width: 50,
                              child: RawMaterialButton(
                                  // constraints: BoxConstraints.tight(const Size(45, 45)),
                                  elevation: 10,
                                  fillColor: Color.fromARGB(255, 243, 90, 79),
                                  child: const Align(
                                      // ignore: unnecessary_const
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.white, size: 22)),
                                  padding: const EdgeInsets.all(15),
                                  shape: const CircleBorder(),
                                  onPressed: () {
                                    pickImageFromDevice();
                                  }),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'نوع الهاتف',
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
                      controller: storeController,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'اسم المتجر',
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
                      controller: spaceController,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'المساحة',
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
                      controller: ramController,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'مساحة الرامات',
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
                    height: 150.h,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 10,
                      style: TextStyle(color: Color.fromARGB(255, 243, 90, 79)),
                      controller: detailsController,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'تفاصيل الهاتف',
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
                      controller: colorController,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'الألوان المتوفرة',
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
                      controller: price1Controller,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'السعر الأول',
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
                      controller: price2Controller,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'السعر الثانى',
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
                      controller: price3Controller,
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
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 243, 90, 79)),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'السعر الثالث',
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
                        String name = nameController.text.trim();
                        String space = spaceController.text.trim();
                        String ram = ramController.text.trim();
                        String details = detailsController.text.trim();
                        String color = colorController.text.trim();
                        String price1 = price1Controller.text.trim();
                        String price2 = price2Controller.text.trim();
                        String price3 = price3Controller.text.trim();
                        String store = storeController.text.trim();
                        int rating = 3;

                        if (name.isEmpty ||
                            space.isEmpty ||
                            imageUrl.isEmpty ||
                            ram.isEmpty ||
                            details.isEmpty ||
                            color.isEmpty ||
                            price1.isEmpty ||
                            price2.isEmpty ||
                            price3.isEmpty) {
                          CherryToast.info(
                            title: Text('ادخل جميع الحقول'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('phones');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'imageUrl': imageUrl,
                            'name': name,
                            'space': space,
                            'rating': rating,
                            'ram': ram,
                            'details': details,
                            'color': color,
                            'price1': price1,
                            'price2': price2,
                            'price3': price3,
                            'store': store,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child:
                          Text('أضافة', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
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
    content: Text("تم أضافة المنتج"),
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
