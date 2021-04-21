import 'package:flutter/material.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/screens/pet_detail.dart';
import 'package:fluuter_provider/home/datalist.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:line_icons/line_icons.dart';

class DataTile extends StatelessWidget {

  final DispData dbData;
  DataTile({this.dbData});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/dog1.jpg'),
              radius: 25.0,
              backgroundColor: Colors.white,
            ),
            enabled: (dbData.status == 'Adopted') ? false : true,
            title: Text(dbData.name),
            subtitle: Text(dbData.description),
            isThreeLine: true,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailScreen(dbData: dbData),
              )
              );
              print('Pressed');
            },
          ),
        ),
      ),
    );
  }
}
