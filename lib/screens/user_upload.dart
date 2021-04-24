import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyUploads extends StatefulWidget {

  @override
  _MyUploadsState createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {


  String _description = '';
  String _gender = '';
  String _breed = '';
  String _name  = '';
  String _location = '';
  int _phone = 0;
  dynamic _userId = '';
  dynamic _docUid = '';



  Future getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Data").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];

      print(a.id);

      if(a.data()['description'] == '5 days old dog'){
        _breed = a.data()['breed'];
        _description = a.data()['description'];
        _name = a.data()['name'];
        _name = a.data()['name'];
        _phone = a.data()['phone'];
        _location = a.data()['location'];
        _userId = a.data()['userId'];
        _docUid = a.id;
      }
    }
  }

  // CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Data');
  // Future getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //
  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data());
  //
  //   print(allData);
  // }

  @override
  Widget build(BuildContext context) {
    getData();
    return Padding(
      padding: const EdgeInsets.fromLTRB(45, 120, 50, 0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body:  Text('$_docUid',
            style: TextStyle(color: Colors.black87,
            fontSize: 15.0),),
      ),
    );
  }
}
