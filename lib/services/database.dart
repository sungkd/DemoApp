import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/modals/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference petData = FirebaseFirestore.instance.collection('Data');

  Future updateUserData(String breed, String gender, String description,
                        String name,  int phone,  String location,
                        String status) async
  {

    return await petData.doc(uid).set(
        {
          'breed': breed,
          'gender': gender,
          'description': description,
          'name' : name,
          'phone': phone,
          'location': location,
          'status': status,
        }
    );
  }

  //Get uploaded data into a list from snapshot
  List<DispData> _dispDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DispData(
        breed: doc.data()['breed'] ?? '',
        gender: doc.data()['gender'] ?? '',
        description: doc.data()['description'] ?? '',
        name: doc.data()['name'] ?? '',
        phone: doc.data()['phone'] ?? 0,
        location: doc.data()['location'] ?? '',
        status: doc.data()['status'] ?? '',

      );
    }).toList();
  }

  //Get data from snapshot
  UploadData1 _uploadData1FromSnapshot (DocumentSnapshot snapshot) {
    return UploadData1(
      uid: uid,
      breed: snapshot.data()['breed'] ?? '',
      gender: snapshot.data()['gender'] ?? '',
      description: snapshot.data()['description'] ?? '',
      name: snapshot.data()['name'] ?? '',
      phone: snapshot.data()['phone'] ?? 0,
      location: snapshot.data()['location'] ?? '',
      status: snapshot.data()['status'] ?? '',

    );
  }


  //Get snapshot of the database
  Stream<List<DispData>> get petUpload {
    return petData.snapshots().map(_dispDataFromSnapshot);
  }

  //Get user uploaded data
  Stream<UploadData1> get uploadData1 {
    return petData.doc(uid).snapshots().map(_uploadData1FromSnapshot);
  }
}