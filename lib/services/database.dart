import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/modals/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference petData = FirebaseFirestore.instance.collection('Data');

  Future updateUserData(String breed, String gender, String description,
      String name,  int phone,  String location, int age,
      String days, String area, int pin, bool neutered,
      String status, dynamic userId,
      String url, String url1, String url2,
      dynamic dateTime) async
  {

    return await petData.doc(uid).set(
        {
          'breed': breed,
          'gender': gender,
          'description': description,
          'name' : name,
          'phone': phone,
          'location': location,
          'age': age,
          'days': days,
          'area': area,
          'pin': pin,
          'neutered': neutered,
          'status': status,
          'userId': userId,
          'imgUrl': url,
          'imgUrl1': url1,
          'imgUrl2': url2,
          'dateTime': dateTime,
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
        age: doc.data()['age'] ?? 0,
        days: doc.data()['days'] ?? '',
        area: doc.data()['area'] ?? '',
        pin: doc.data()['pin'] ?? 0,
        neutered: doc.data()['neutered'] ?? false,
        status: doc.data()['status'] ?? '',
        userId: doc.data()['userId'] ?? '',
        uid: doc.id ?? '',
        imgUrl: doc.data()['imgUrl'] ?? '',
        imgUrl1: doc.data()['imgUrl1'] ?? '',
        imgUrl2: doc.data()['imgUrl2'] ?? '',
        dateTime: doc.data()['dateTime'] ?? '',

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
      age:snapshot.data()['age'],
      days: snapshot.data()['days'],
      area: snapshot.data()['area'],
      pin: snapshot.data()['pin'],
      neutered: snapshot.data()['neutered'],
      status: snapshot.data()['status'] ,
      userId: snapshot.data()['userId'] ,
      imgUrl: snapshot.data()['imgUrl'] ,
      imgUrl1: snapshot.data()['imgUrl1'] ,
      imgUrl2: snapshot.data()['imgUrl2'] ,
      dateTime: snapshot.data()['dateTime'] ,

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


class UserDetails {

  final dynamic userUid;
  UserDetails({this.userUid});

  //Collection Reference
  final CollectionReference createUsers = FirebaseFirestore.instance.collection('User');

  Future createUser(String name) async
  {

    return await createUsers.doc().set(
        {
          'userName': name,
          'userUid':  userUid,
        }
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
