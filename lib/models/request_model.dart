import 'package:firebase_database/firebase_database.dart';

class Request {
  int? currentNumber;
  String? uid;
  String? month;
  String? name;
  int? offer;
  String? phoneNumber;
  String? status;
  String? id;

  Request(
      {this.currentNumber,
      this.uid,
      this.month,
      this.name,
      this.offer,
      this.phoneNumber,
      this.status,
      this.id});

  Request.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot.child("uid").value.toString());
    currentNumber = (dataSnapshot.child("currentNumber").value) as int?;
    name = (dataSnapshot.child("name").value.toString());
    month = (dataSnapshot.child("month").value.toString());
    offer = (dataSnapshot.child("offer").value) as int?;
    phoneNumber = (dataSnapshot.child("phoneNumber").value.toString());
    status = (dataSnapshot.child("status").value.toString());
    id = (dataSnapshot.child("id").value.toString());
  }
}