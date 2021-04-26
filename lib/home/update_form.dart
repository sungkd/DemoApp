import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/constants/decorate.dart';
import 'package:fluuter_provider/constants/loading.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/services/database.dart';


class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> upStatus = ['Adopted', 'Not Adopted'];

  Stream<DocumentSnapshot> petData = FirebaseFirestore.instance.collection('Data')
      .doc().snapshots();


  //Form Values
  String _currentName, _currentstatus;
  int _currentage;

  @override
  Widget build(BuildContext context) {
    final getuser = Provider.of<UserData>(context);

    return SingleChildScrollView(
      child: StreamBuilder<UploadData1>(
          stream: DatabaseService(uid: 'cKd42lbiVMDFfWyW6Buu').uploadData1,
          builder: (context, snapshot) {
            UploadData1 uploadData1 = snapshot.data;
            if(snapshot.hasData) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Update Adoption Status',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 20),

                    TextFormField(
                      initialValue: uploadData1.uid,
                      decoration: textInputDecoration,
                      validator: (val) =>
                      val.isEmpty
                          ? 'Please enter a name'
                          : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormField(
                      value: _currentstatus ?? uploadData1.status,
                      decoration: textInputDecoration,
                      items: upStatus.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text('$status'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => _currentstatus = val);
                      },
                    ),

                    SizedBox(height: 15),
                    //Slider
                    Slider(
                      value: (_currentage ?? 100).toDouble(),
                      activeColor: Colors.red[_currentage ?? 100],
                      inactiveColor: Colors.brown,
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentage = val.round()),

                    ),


                    ElevatedButton(
                      child: Text('Update',
                        style: TextStyle(color: Colors.black87),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          // await DatabaseService(uid: 'cKd42lbiVMDFfWyW6Buu').updateUserData(
                          //     uploadData1.breed, uploadData1.gender, _currentName ?? uploadData1.description,
                          //     uploadData1.name, uploadData1.phone, uploadData1.location,
                          //     _currentstatus ?? uploadData1.status,
                          //     getuser.uid, uploadData1.imgUrl);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                        // print(_currentName);
                        // print(_currentage);
                        // print(_currentstatus);
                      },
                    )
                  ],
                ),
              );
            }
            else
            {
              return Loading();
            }
          }
      ),
    );
  }
}