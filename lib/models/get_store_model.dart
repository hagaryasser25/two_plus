import 'package:firebase_database/firebase_database.dart';

class Stores {
  String? email;
  String? uid;
  String? phoneNumber;
  String? fullName;
  String? imageUrl;
  String? password;
  String? isSubscribe;
  String? id;

  Stores(
      {this.email,
      this.uid,
      this.phoneNumber,
      this.fullName,
      this.imageUrl,
      this.password,
      this.isSubscribe,
      this.id});

  Stores.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot.child("uid").value.toString());
    email = (dataSnapshot.child("email").value.toString());
    fullName = (dataSnapshot.child("name").value.toString());
    phoneNumber = (dataSnapshot.child("phoneNumber").value.toString());
    imageUrl = (dataSnapshot.child("imageUrl").value.toString());
    password = (dataSnapshot.child("password").value.toString());
    isSubscribe = (dataSnapshot.child("isSubscribe").value.toString());
    id = (dataSnapshot.child("id").value.toString());
  }
}
