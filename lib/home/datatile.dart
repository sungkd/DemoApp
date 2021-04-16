import 'package:flutter/material.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';

class DataTile extends StatelessWidget {

  final DispData dbData;
  DataTile({this.dbData});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/dog1.jpg'),
            radius: 25.0,
            backgroundColor: Colors.white,
          ),
          title: Text(dbData.status),
          subtitle: Text(dbData.description),
        ),
      ),
    );
  }
}
