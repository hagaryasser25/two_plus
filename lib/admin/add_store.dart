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
import 'admin_home.dart';

class AddStore extends StatefulWidget {
  static const routeName = '/addStore';
  const AddStore({super.key});

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  
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
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: SingleChildScrollView(
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Choose option',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Color.fromARGB(255, 243, 90, 79))),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          pickImageFromDevice();
                                                        },
                                                        splashColor:
                                                            HexColor('#FA8072'),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                  Icons.image,
                                                                  color: Color.fromARGB(255, 243, 90, 79)),
                                                            ),
                                                            Text('Gallery',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ))
                                                          ],
                                                        )),
                                                    InkWell(
                                                        onTap: () {
                                                          // pickImageFromCamera();
                                                        },
                                                        splashColor:
                                                            HexColor('#FA8072'),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                  Icons.camera,
                                                                  color: Color.fromARGB(255, 243, 90, 79)),
                                                            ),
                                                            Text('Camera',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ))
                                                          ],
                                                        )),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        splashColor:
                                                            HexColor('#FA8072'),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                  Icons
                                                                      .remove_circle,
                                                                  color: Color.fromARGB(255, 243, 90, 79)),
                                                            ),
                                                            Text('Remove',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ))
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 90, 79), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'الأسم',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 90, 79), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'البريد الالكترونى',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 90, 79), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'كلمة المرور',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 90, 79), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'رقم الهاتف',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        String name = nameController.text.trim();
                        String email = emailController.text.trim();
                        String role = 'متجر';
                        String phoneNumber = phoneNumberController.text.trim();
                        String password = passwordController.text.trim();
                        int rating = 3;

                        if (name.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            phoneNumber.isEmpty ||
                            imageUrl.isEmpty) {
                          CherryToast.info(
                            title: Text('Please Fill all Fields'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        if (password.length < 6) {
                          // show error toast
                          CherryToast.info(
                            title: Text(
                                'Weak Password, at least 6 characters are required'),
                            actionHandler: () {},
                          ).show(context);

                          return;
                        }

                        ProgressDialog progressDialog = ProgressDialog(context,
                            title: Text('Signing Up'),
                            message: Text('Please Wait'));
                        progressDialog.show();

                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          UserCredential userCredential =
                              await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          User? user = userCredential.user;
                          user!.updateProfile(displayName: role);

                          if (userCredential.user != null) {
                            DatabaseReference userRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('stores');
                            String? id = userRef.push().key;

                            String uid = userCredential.user!.uid;
                            int dt = DateTime.now().millisecondsSinceEpoch;

                            await userRef.child(uid).set({
                              'name': name,
                              'email': email,
                              'password': password,
                              'uid': uid,
                              'phoneNumber': phoneNumber,
                              'id': id,
                              'imageUrl': imageUrl,
                              'isSubscribe': 'false',
                            });

                            DatabaseReference centerRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('users');

                            await centerRef.child(uid).set({
                              'name': name,
                              'email': email,
                              'password': password,
                              'uid': uid,
                              'dt': dt,
                              'phoneNumber': phoneNumber,
                            });

                            FirebaseAuth.instance.signOut();
                            Navigator.canPop(context)
                                ? Navigator.pop(context)
                                : null;
                          } else {
                            CherryToast.info(
                              title: Text('Failed'),
                              actionHandler: () {},
                            ).show(context);
                          }
                          progressDialog.dismiss();
                        } on FirebaseAuthException catch (e) {
                          progressDialog.dismiss();
                          if (e.code == 'email-already-in-use') {
                            CherryToast.info(
                              title: Text('Email is already exist'),
                              actionHandler: () {},
                            ).show(context);
                          } else if (e.code == 'weak-password') {
                            CherryToast.info(
                              title: Text('Password is weak'),
                              actionHandler: () {},
                            ).show(context);
                          }
                        } catch (e) {
                          progressDialog.dismiss();
                          CherryToast.info(
                            title: Text('Something went wrong'),
                            actionHandler: () {},
                          ).show(context);
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xfff8a55f),
                            Color.fromARGB(255, 243, 90, 79)
                          ]),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          constraints: const BoxConstraints(minWidth: 88.0),
                          child: const Text('حفظ', textAlign: TextAlign.center),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
    content: Text("تم أضافة المتجر"),
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
