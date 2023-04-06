import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:two_plus/admin/add_offer.dart';
import 'package:two_plus/admin/add_store.dart';
import 'package:two_plus/admin/admin_complains.dart';
import 'package:two_plus/admin/admin_home.dart';
import 'package:two_plus/admin/admin_offers.dart';
import 'package:two_plus/admin/admin_stores.dart';
import 'package:two_plus/admin/admin_subscription.dart';
import 'package:two_plus/auth/admin_login.dart';
import 'package:two_plus/auth/login_page.dart';
import 'package:two_plus/auth/signup_page.dart';
import 'package:two_plus/auth/splash_screen.dart';
import 'package:two_plus/auth/store_login.dart';
import 'package:two_plus/store/send_complain.dart';
import 'package:two_plus/store/store_home.dart';
import 'package:two_plus/store/store_offers.dart';
import 'package:two_plus/store/store_replays.dart';
import 'package:two_plus/store/store_subscription.dart';
import 'package:two_plus/user/send_complain.dart';
import 'package:two_plus/user/user_favourite.dart';
import 'package:two_plus/user/user_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const SplashScreen()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : FirebaseAuth.instance.currentUser!.displayName == 'متجر'
                  ? const StoreHome()
                  : UserHome(),
      routes: {
        SignupPage.routeName: (ctx) => SignupPage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        AddStore.routeName: (ctx) => AddStore(),
        AdminStores.routeName: (ctx) => AdminStores(),
        AdminOffers.routeName: (ctx) => AdminOffers(),
        AddOffer.routeName: (ctx) => AddOffer(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        AdminSubscription.routeName: (ctx) => AdminSubscription(),
        UserSubscription.routeName: (ctx) => UserSubscription(),
        StoreLogin.routeName: (ctx) => StoreLogin(),
        StoreHome.routeName: (ctx) => StoreHome(),
        StoreReplays.routeName: (ctx) => StoreReplays(),
        StoreOffers.routeName: (ctx) => StoreOffers(),
        UserHome.routeName: (ctx) => UserHome(),
        UserFavourite.routeName: (ctx) => UserFavourite(),
        SendComplain.routeName: (ctx) => SendComplain(),
        AdminComplains.routeName: (ctx) => AdminComplains(),
        UserComplain.routeName: (ctx) => UserComplain(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
      },
    );
  }
}
