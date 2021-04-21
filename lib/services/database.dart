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
      String status, dynamic userId) async
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
          'userId': userId,
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
        userId: doc.data()['userId'] ?? '',
        uid: doc.id ?? '',

      );
    }).toList();
  }

  //Get data from snapshot
  UploadData1 _uploadData1FromSnapshot (DocumentSnapshot snapshot) {
    return UploadData1(
      uid: uid,
      breed: snapshot.data()['breed'] ,
      gender: snapshot.data()['gender'] ,
      description: snapshot.data()['description'] ,
      name: snapshot.data()['name'] ,
      phone: snapshot.data()['phone'] ,
      location: snapshot.data()['location'] ,
      status: snapshot.data()['status'] ,
      userId: snapshot.data()['userId'] ,

    );
  }


  //Get snapshot of the database
  Stream<List<DispData>> get petUpload {
    return petData.snapshots().map(_dispDataFromSnapshot);
  }

  //Get user uploaded data
  Stream<UploadData1> get uploadData1 {
    return petData.doc(uid).snapshots().map(_uploadData1FromSnapshot);
    //return petData.doc().snapshots().map(_uploadData1FromSnapshot);
  }
}


class ProcessUid {

  String _description = '';
  String _gender = '';
  String _breed = '';
  String _name  = '';
  String _location = '';
  String _status = '';
  int _phone = 0;
  dynamic _userId = '';
  dynamic _docUid = '';

  //Collection Reference
  final CollectionReference petData = FirebaseFirestore.instance.collection('Data');

  //Get data from snapshot
  GetUidOfDocument _uGetUidOfDocumentFromSnapshot (DocumentSnapshot snapshot) {
    return GetUidOfDocument(
      breed: snapshot.data()['breed'] ,
      gender: snapshot.data()['gender'] ,
      description: snapshot.data()['description'] ,
      name: snapshot.data()['name'] ,
      phone: snapshot.data()['phone'] ,
      location: snapshot.data()['location'] ,
      status: snapshot.data()['status'] ,
      userId: snapshot.data()['userId'] ,
      uid: snapshot.id,

    );
  }


  // Future getData() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Data").get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //
  //     print('Inside loop');
  //     _breed = a.data()['breed'];
  //     _description = a.data()['description'];
  //     _name = a.data()['name'];
  //     _gender = a.data()['gender'];
  //     _phone = a.data()['phone'];
  //     _location = a.data()['location'];
  //     _userId = a.data()['userId'];
  //     _status = a.data()['status'];
  //     _docUid = a.id;
  //
  //
  //     if((a.data()['description'] == "description") &&
  //         (_userId = a.data()['userId'] == "userId" ) )
  //     {
  //
  //     }
  //     else {
  //       print('Error');
  //     }
  //   }
  //
  // }

// final CollectionReference petData = FirebaseFirestore.instance.collection('Data');
//
// Future updateAdoptStatus(String breed, String gender, String description,
//     String name,  int phone,  String location,
//     String status, dynamic userId) async
// {
//   print('1223- $_description');
//
//   return await petData.doc(_docUid).set(
//       {
//         'breed': _breed,
//         'gender': _gender,
//         'description': _description,
//         'name' : _name,
//         'phone': _phone,
//         'location': _location,
//         'status': _status,
//         'userId': _userId,
//       }
//   );
// }



}