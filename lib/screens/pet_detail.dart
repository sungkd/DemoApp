import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/services/database.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/modals/user.dart';


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
    bool isUpdated = false;

    return Scaffold(
      backgroundColor: Color(0xff416d6d),
      appBar: AppBar(
        backgroundColor: Color(0xff416d6d),
        title: RichText(
          text: TextSpan(
            text: 'Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(LineIcons.angleLeft,
          color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          (getuser.uid == dbData.userId) ? TextButton.icon(
              onPressed: () {
                showDialog(context: context,
                    builder: (context) {
                  return AlertDialog(
                    title: RichText(
                      text: TextSpan(
                          text: 'Update Status',
                          style: TextStyle(color: Colors.white,
                          fontSize: 20.0)
                      ),
                    ),
                    content: RichText(
                      text: TextSpan(
                          text: 'Change status to Adopted?'
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          DatabaseService(uid: dbData.uid).updateUserData(dbData.breed,
                              dbData.gender, dbData.description, dbData.name, dbData.phone,
                              dbData.location, 'Adopted', dbData.userId,dbData.imgUrl);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    shape: RoundedRectangleBorder(),
                    elevation: 24.0,
                    backgroundColor: Colors.black87,
                  );
                    }
                );
              },
              icon: Icon(LineIcons.editAlt, color: Colors.white,),
              label: RichText(
                text: TextSpan(
                  text: 'Status'
                ),
              )
          ) : IconButton(
              icon: Icon(LineIcons.timesCircle,
              color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
      ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                CircleAvatar(
                  // backgroundImage: AssetImage('assets/cat2.jpg'),
                  backgroundImage: NetworkImage(dbData.imgUrl),
                  radius: 120.0,
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
                                             Text(isUpdated ? 'Adopted'
                                               : dbData.status,
                                               style: TextStyle(
                                                 fontSize: 18.0,
                                                 letterSpacing: 1.0,
                                                 wordSpacing: 1.0,
                                               ),
                                             ),
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
      ),
      ),
    );
  }
}




