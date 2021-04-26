import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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
  String _age = '';
  String _area = '';
  String _pin = '';
  String _days = '';
  String url = '';
  String _isneutered = 'no';
  bool _neutered = false;


  final List<String> petBreed = ['Indie', 'Mixed', 'Pure'];
  final List<String> petGender = ['Male', 'Female'];

  final _formKey = GlobalKey<FormState>();

  PickedFile pickedImage;
  File _image;
  File imageFile;
  String fileName = '';
  String _error = '' ;

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

  @override
  Widget build(BuildContext context) {

    double _containerWidth = 380;
    // double _containerHeight = MediaQuery.of(context).size.height;
    double _containerHeight = 1500;

    final getuser = Provider.of<UserData>(context);
    final CollectionReference petData = FirebaseFirestore.instance.collection('Data');
    FirebaseStorage storage = FirebaseStorage.instance;


    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Color(0xffFF045C5C),
        elevation: 1.2,
        title: RichText(
          text: TextSpan(
            text: "Adoption Request",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 15.0,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            child: _image == null ? InkResponse(
                              onTap: () {
                                //Select image from gallery
                                getImage('gallery');
                              },
                              child: Icon(LineIcons.camera,
                                          size: 50,),
                            ) : InkResponse(
                              onTap: () {
                                //Select image from gallery
                                getImage('gallery');
                              },
                              child: CircleAvatar(
                                backgroundImage: FileImage(_image,
                                scale: 1),
                                radius: 70,
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: _image != null ? EdgeInsets.all(0) : EdgeInsets.all(35),
                            decoration: _image != null ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200]
                            ) : BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          ),

                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Breed',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Mixed/Pure/Indie',
                            isDense: true,
                        ),
                        validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                        : (val.toLowerCase() == 'mixed')  ? null
                        : (val.toLowerCase() == 'indie')  ? null
                        : (val.toLowerCase() == 'pure')   ? null
                        : 'Breed should be Mixed, Pure or Indie',

                        onChanged: (val) {
                          setState(() => _breed = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Gender',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Male/Female'
                        ),
                        validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                            : (val.toLowerCase() == 'male')  ? null
                            : (val.toLowerCase() == 'female')  ? null
                            : 'Gender should be Male or Female' ,

                        onChanged: (val) {
                          setState(() => _gender = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: 'Age',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(width: 50,),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: 'Days',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black87),
                              decoration: richTextDecoration.copyWith(
                                  labelText: '1'
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val) => (val.isEmpty) ? 'Enter approx age'
                                  : (val.length <= 2) ? null
                                  : 'Age cannot be greater than 2 digits',

                              onChanged: (val) {
                                setState(() => _age = val);
                              },
                            ),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            width: 180,
                            height: 50,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black87),
                              decoration: richTextDecoration.copyWith(
                                  labelText: 'Week/Month/Year'
                              ),

                              validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                                  : (val.toLowerCase() == 'week')  ? null
                                  : (val.toLowerCase() == 'month') ? null
                                  : (val.toLowerCase() == 'year')  ? null
                                  : 'Age should be in week month or year' ,

                              onChanged: (val) {
                                setState(() => _days = val);
                              },
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Neutered or Spayed',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Yes/No',
                          isDense: true,
                        ),
                        validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                            : (val.toLowerCase() == 'yes')  ? null
                            : (val.toLowerCase() == 'no')   ? null
                            : 'Value can be yes or no' ,

                        onChanged: (val) {
                          setState(() => _isneutered = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Details',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        maxLines: 5,
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Pet Detail',
                        ),
                        validator: (val) => (val.isEmpty) ? 'Enter details'
                        : null,
                        onChanged: (val) {
                          setState(() => _description = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Contact Person',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Name'
                        ),
                        validator: (val) => (val.isEmpty) ? 'Enter name'
                            : null,
                        onChanged: (val) {
                          setState(() => _name = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Phone',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Phone number'
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val) => (val.isEmpty) ? 'Enter phone number'
                        : (val.length == 10) ? null : 'Phone number should be of 10 digits',
                        onChanged: (val) {
                          setState(() => _phone = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'City',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'City',
                            hintText: 'Mumbai',
                        ),
                        validator: (val) => (val.isEmpty) ? 'Mention nearest city name'
                        : null,
                        onChanged: (val) {
                          setState(() => _location = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Area',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Area',
                          hintText: '90 Feet Road, Bhandup East',
                        ),
                        validator: (val) => (val.isEmpty) ? 'Enter area name'
                            : (val.length <= 45) ? 'Cannot enter more than 45 characters'
                            : null,
                        onChanged: (val) {
                          setState(() => _area = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Pin code',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),


                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Pin code',
                          hintText: '400042',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val) => (val.isEmpty) ? 'Enter pin code'
                            : (val.length == 6) ? null
                            : 'Pin code cannot be more than 6 digits',
                        onChanged: (val) {
                          setState(() => _pin = val);
                        },
                      ),

                      SizedBox(height: 20,),

                      TextButton(
                        child: Text('Upload',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        style: textButtonStyle,
                        onPressed: () async {
                          if(_formKey.currentState.validate() && _image != null) {

                            await storage.ref(fileName).putFile(
                                imageFile,
                                SettableMetadata(customMetadata: {
                                  'uploaded_by': _name,
                                  'description': DateTime.now().toString()
                                }
                                )
                            );

                            url  = await FirebaseStorage.instance
                                   .ref(fileName).getDownloadURL();

                            if (url != null) {

                              _isneutered == 'yes' ?
                                    _neutered = true
                                  : _neutered = false;


                              petData.doc().set( {
                                'breed': _breed,
                                'gender': _gender,
                                'description': _description,
                                'name' : _name,
                                'phone': int.parse(_phone),
                                'location': _location,
                                'age': int.parse(_age),
                                'days': _days,
                                'area': _area,
                                'pin': int.parse(_pin),
                                'neutered': _neutered,
                                'status': 'Not Adopted',
                                'userId': getuser.uid,
                                'imgUrl': url,

                                }
                              );
                              Navigator.pop(context);
                            }
                            else {
                              _error = 'Error while loading data';
                            }

                          }
                          else{
                            _error = 'Value in all the fields is not entered';
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          '$_error',
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: _containerWidth,
                height: _containerHeight,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
