import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/modals/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference petData = FirebaseFirestore.instance.collection('Data');

  Future updateUserData(String breed, String gender, String description,
      String name,  int phone,  String location,
      String status, dynamic userId, String url) async
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
          'imgUrl': url,
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
        imgUrl: doc.data()['imgUrl'] ?? '',

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
      imgUrl: snapshot.data()['imgUrl'] ,

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
      imgUrl: snapshot.data()['imgUrl'] ,

    );
  }
}


// class UploadImage {
//
//   FirebaseStorage storage = FirebaseStorage.instance;
//
//   // Select and image from the gallery or take a picture with the camera
//   // Then upload to Firebase Storage
//   Future<void> _upload(String inputSource) async {
//     final picker = ImagePicker();
//     PickedFile pickedImage;
//       try {
//             pickedImage = await picker.getImage(
//                 source: ImageSource.gallery,
//                 maxWidth: 1920);
//       }
//       catch (e) {
//         print('$e');
//       }
//     }
// }
