import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addParking(
    String uid, String plate, String location, String time) async {
  CollectionReference parking =
      FirebaseFirestore.instance.collection('parking');
  return parking
      .add({
        'uid': uid,
        'plate': plate,
        'location': location,
        'time': time,
      })
      .then((value) => print("Parking Added"))
      .catchError((error) => print("Failed to add parking: $error"));
}
