import 'package:flutter/material.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/screens/pet_detail.dart';

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
            tileColor: (dbData.status == 'Adopted') ? Colors.grey : Colors.white,
            shape: CircleBorder(),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(dbData.imgUrl),
              radius: 30.0,
              backgroundColor: Colors.white,
            ),
            enabled: (dbData.status == 'Adopted') ? false : true,
            title: Text(dbData.status),
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
