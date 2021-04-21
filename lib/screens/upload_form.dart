import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluuter_provider/services/database.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/constants/decorate.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class UploadForm extends StatefulWidget {
  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {

  String _breed = '';
  String _name = '';
  String _location = '';
  String _gender = '';
  String _description = '';
  String _phone = '';
  String url = '';


  final List<String> petBreed = ['Indie', 'Mixed', 'Pure'];
  final List<String> petGender = ['Male', 'Female'];

  final _formKey = GlobalKey<FormState>();

  PickedFile pickedImage;
  File _image;
  File imageFile;
  String fileName = '';

  Future getImage(String _gallery) async {


    final picker = ImagePicker();

    if(_gallery == 'gallery') {
      pickedImage = await picker.getImage(source: ImageSource.gallery);
    }
     fileName = path.basename(pickedImage.path);
     imageFile = File(pickedImage.path);

    setState(() {
      _image = imageFile;

    });
    print('$fileName');
    print('$imageFile');

  }

  getImageURL({String name}) async {
    url  = await FirebaseStorage.instance.ref(fileName).getDownloadURL();
    print('$url');
  }


  String _value = '';
  @override
  Widget build(BuildContext context) {

    final getuser = Provider.of<UserData>(context);
    final CollectionReference petData = FirebaseFirestore.instance.collection('Data');
    FirebaseStorage storage = FirebaseStorage.instance;



    return Scaffold(
        backgroundColor: Colors.teal[800],
        appBar: AppBar(
          title: Text('Upload'),
          backgroundColor: Color(0xff416d6d),
          leading: IconButton(
            icon: Icon(LineIcons.backward,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                     TextFormField(
                         style: TextStyle(color: Colors.white),
                         decoration: textInputDecoration.copyWith(hintText: 'Enter breed',
                         hintStyle: TextStyle(color: Colors.white),
                         icon:  Icon(LineIcons.dog, color: Colors.white,)),
                         validator: (val) => val.isEmpty ? 'Enter a breed' : null,
                         onChanged: (val) {
                            setState(() => _breed = val);
                         },
                     ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: textInputDecoration.copyWith(hintText: 'Gender',
                              hintStyle: TextStyle(color: Colors.white),
                              icon:  Icon(LineIcons.mars, color: Colors.white,)),
                          validator: (val) => val.isEmpty ? 'Enter Gender' : null,
                          onChanged: (val) {
                            setState(() => _gender = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: textInputDecoration.copyWith(hintText: 'Description',
                              hintStyle: TextStyle(color: Colors.white),
                              icon:  Icon(LineIcons.pen, color: Colors.white,)),
                          validator: (val) => val.isEmpty ? 'Enter Description' : null,
                          onChanged: (val) {
                            setState(() => _description = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: textInputDecoration.copyWith(hintText: 'Contact Person Name',
                              hintStyle: TextStyle(color: Colors.white),
                              icon:  Icon(LineIcons.userCircle, color: Colors.white,)),
                          validator: (val) => val.isEmpty ? 'Enter name' : null,
                          onChanged: (val) {
                            setState(() => _name = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType:TextInputType.number,
                          decoration: textInputDecoration.copyWith(hintText: 'Phone Number',
                              hintStyle: TextStyle(color: Colors.white),
                              icon:  Icon(LineIcons.phoneSquare, color: Colors.white,)),
                          validator: (val) => val.isEmpty ? 'Enter phone number' : null,
                          onChanged: (val) {
                            setState(() => _phone = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: textInputDecoration.copyWith(hintText: 'Location',
                              hintStyle: TextStyle(color: Colors.white),
                              icon:  Icon(LineIcons.mapMarker, color: Colors.white,)),
                          validator: (val) => val.isEmpty ? 'Enter a location' : null,
                          onChanged: (val) {
                            setState(() => _location = val);
                          },
                        ),
                        SizedBox(height: 35,),
                        ElevatedButton.icon(
                            label: Text('Upload Image'),
                            icon: Icon(LineIcons.camera,),
                            onPressed: () {
                              print('Image button pressed');

                              //Select image from gallery
                              getImage('gallery');

                            },
                            // child: Text('Upload Image'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red , //background
                            )
                        ),
                        _image == null ? Container() : Image.file(_image,
                        width: 150,
                        height: 150,),
                        SizedBox(height: 25,
                        child: ElevatedButton(
                          child: Text('Upload'),
                          onPressed: () async {

                        // await storage.ref(fileName).putFile(
                        //         imageFile,
                        //         SettableMetadata(customMetadata: {
                        //           'uploaded_by': 'A bad guy',
                        //           'description': 'Some description...'
                        //         }));
                        //
                        // getImageURL();

                          },
                        ),),
                        SizedBox(height: 35,),

                        /*Display Selected image
                        * _image == null ? Container() : Image.file(_image,),
                        * */

                        ElevatedButton(
                            child: Text('Submit'),
                          onPressed: () async {
                            if(_formKey.currentState.validate()) {

                              await storage.ref(fileName).putFile(
                                  imageFile,
                                  SettableMetadata(customMetadata: {
                                    'uploaded_by': 'A bad guy',
                                    'description': 'Some description...'
                                  }));

                              url  = await FirebaseStorage.instance.ref(fileName).getDownloadURL();

                              print('out $url');

                              petData.doc().set( {
                                'breed': _breed,
                                'gender': _gender,
                                'description': _description,
                                'name' : _name,
                                'phone': int.parse(_phone),
                                'location': _location,
                                'status': 'Not Adopted',
                                'userId': getuser.uid,
                                'imgUrl': url,

                              });

                              Navigator.pop(context);

                              // print(_breed);
                              // print(_gender);
                              // print(_description);
                              // print(_location);
                              // print(_name);

                            //   await DatabaseService(uid: getuser.uid).updateUserData(
                            //       _breed, _gender, _description,
                            //       _name, int.parse(_phone), _location, 'Not Adopted');
                            //   Navigator.pop(context);
                             }
                            else {
                              return "error";
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
        ),
      );
  }
}
