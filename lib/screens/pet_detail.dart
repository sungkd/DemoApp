import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/services/database.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:fluuter_provider/screens/user_upload.dart';
import 'package:fluuter_provider/home/update_form.dart';
import 'package:fluuter_provider/services/database.dart';


class DetailScreen extends StatelessWidget {
  
  final DispData dbData;
  DetailScreen({this.dbData});

  void _launchCaller(int number) async {
    var url = "tel:${number.toString()}";
    if(await canLaunch(url)) {
      await launch(url);
    }
    else
      {
        throw 'Cannot connect call';
      }
  }


  @override
  Widget build(BuildContext context) {
    
    final totSize = MediaQuery.of(context).size;
    final getuser = Provider.of<UserData>(context);

    void _showUpdatePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: MyUploads()
            );
          }
      );
    }

    return Scaffold(
      backgroundColor: Color(0xff416d6d),
      appBar: AppBar(
        backgroundColor: Color(0xff416d6d),
        leading: IconButton(
          icon: Icon(LineIcons.backward,
          color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          (getuser.uid == dbData.userId) ? IconButton(
            icon: Icon(LineIcons.facebook,
              color: Colors.white,
            ),
            onPressed: () {
              print('${dbData.uid}');
              DatabaseService(uid: dbData.uid).updateUserData(dbData.breed,
                  dbData.gender, dbData.description, dbData.name, dbData.phone,
                  dbData.location, 'Adopted', dbData.userId,dbData.imgUrl);
            },
          ) : IconButton(
              icon: Icon(LineIcons.timesCircle,
              color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                print('false');
              },
      ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: [
              CircleAvatar(
                // backgroundImage: AssetImage('assets/cat2.jpg'),
                backgroundImage: NetworkImage(dbData.imgUrl),
                radius: 100.0,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 100),
                    padding:EdgeInsets.fromLTRB(0, 120, 0, totSize.height),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                 Column(
                   children: [
                     Row(
                       children: [
                         Expanded(
                             child: Padding(
                               padding: const EdgeInsets.fromLTRB(25, 30, 0, 0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('Breed',
                                   style: TextStyle(
                                     fontSize: 20.0,
                                     letterSpacing: 1.0,
                                     fontWeight: FontWeight.bold,
                                   ),),
                                   Row(
                                     children: [
                                       Text(dbData.breed,
                                       style: TextStyle(
                                         fontSize: 18.0,
                                         letterSpacing: 1.0,
                                         wordSpacing: 1.0,
                                       ),),
                                       SizedBox(width: 250,),
                                       (dbData.gender == 'male') ?
                                       Icon(LineIcons.mars,
                                       size: 35.0,
                                       color: Colors.red,) :
                                       Icon(LineIcons.venus,
                                       size: 35.0,
                                       color: Colors.pink,),
                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('Description',
                                         style: TextStyle(
                                           fontSize: 20.0,
                                           letterSpacing: 1.0,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                       SizedBox(height: 5),
                                       Wrap(
                                         direction: Axis.horizontal,
                                         children: [
                                            Text(dbData.description,
                                                 style: TextStyle(
                                                 fontSize: 15.0,
                                                 letterSpacing: 1.0,
                                                 wordSpacing: 1.0,),
                                            ),
                                         ],
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('Status',
                                         style: TextStyle(
                                           fontSize: 20.0,
                                           letterSpacing: 1.0,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                       SizedBox(height: 5,),
                                       Row(
                                         children: [
                                           Text(dbData.status,
                                             style: TextStyle(
                                               fontSize: 18.0,
                                               letterSpacing: 1.0,
                                               wordSpacing: 1.0,
                                             ),),
                                         ],
                                       ),

                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('Contact',
                                         style: TextStyle(
                                           fontSize: 20.0,
                                           letterSpacing: 1.0,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                       SizedBox(height: 5,),
                                       Row(
                                         children: [
                                           Text(dbData.name,
                                             style: TextStyle(
                                               fontSize: 18.0,
                                               letterSpacing: 1.0,
                                               wordSpacing: 1.0,
                                             ),),
                                         ],
                                       ),

                                     ],
                                   ),
                                   SizedBox(height: 20),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         children: [
                                           Icon(LineIcons.mapMarker,
                                             size: 25.0,
                                             color: Colors.red,),
                                           Wrap(direction: Axis.horizontal,
                                               children: [Text(dbData.location)]
                                           ),

                                         ],
                                       )
                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         children: [
                                           ElevatedButton(
                                               onPressed: () {
                                                 _launchCaller(dbData.phone);
                                               },
                                               child: Icon(LineIcons.phone,
                                               size: 25.0,
                                               color: Colors.white,),
                                              style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                              foregroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                                              ),),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                         ),
                       ],
                     ),
                   ],
                 ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}




