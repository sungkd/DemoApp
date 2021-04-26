import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/screens/pet_detail.dart';

class DataTile extends StatelessWidget {

  final DispData dbData;
  DataTile({this.dbData});


  @override
  Widget build(BuildContext context) {

    final double _radius = 16;

    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    final cachedImage = new CachedNetworkImage(
      // placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: dbData.imgUrl,

    );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: GestureDetector(
          onTap: () {
            dbData.status == 'Not Adopted' ?
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailScreen(dbData: dbData),
                )
                ) : ScaffoldMessenger.of(context).showSnackBar(SnackBar
                    (content: Text('Pet Adopted')));
          },
          child: Card(
            color: dbData.status == 'Adopted' ? Colors.grey : Colors.white,
            shape: RoundedRectangleBorder(borderRadius:
                   BorderRadius.circular(18.0),),
            elevation: 10.0,
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
            child: Row(
              children: [
                Expanded(child: buildText(dbData.status,dbData.breed)),
                // GestureDetector(child: Expanded(child:
                // buildText(dbData.status,dbData.breed),),
                // onTap: () {
                //   dbData.status == 'Not Adopted' ?
                //       Navigator.push(context, MaterialPageRoute(
                //           builder: (context) => DetailScreen(dbData: dbData),
                //       )
                //       ) : ScaffoldMessenger.of(context).showSnackBar(SnackBar
                //           (content: Text('Pet Adopted')));
                // },),
                //Spacer(),
                buildImage(_radius, dbData.imgUrl),
              ],
            ),
            // child: ListTile(
            //   tileColor: (dbData.status == 'Adopted') ? Colors.grey : Colors.white,
            //   leading: CircleAvatar(
            //     backgroundImage: NetworkImage(dbData.imgUrl),
            //     radius: 30.0,
            //     backgroundColor: Colors.white,
            //   ),
            //   enabled: (dbData.status == 'Adopted') ? false : true,
            //   title: Text(dbData.status),
            //   subtitle: Text(dbData.description),
            //   isThreeLine: true,
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(
            //         builder: (context) => DetailScreen(dbData: dbData),
            //     )
            //     );
            //     print('Pressed');
            //   },
            // ),
          ),
        ),
      ),
    );
  }

  Widget buildText(String status, String description) => Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(text: TextSpan(text: status,
                style: TextStyle(color: Colors.black87, fontSize: 20))),
          ],
        ),
        Column(
          children: [
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: [
                RichText(text: TextSpan(text: description,
                    style: TextStyle(color: Colors.grey, fontSize: 15))),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget buildImage(double radius, imgUrl) => ClipRRect(
    borderRadius: BorderRadius.horizontal(
      right: Radius.circular(radius),),
    // child: Image.network(imgUrl, fit: BoxFit.cover, width: 120, height: 120,),

    child: CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(
        backgroundColor: Colors.grey[600],
        strokeWidth: 2,
      ),
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    ),
  );

  buildImgText(String status, String description, double radius, imgUrl,
      double width, double height ) =>
      Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RichText(text: TextSpan(text: status,
                    style: TextStyle(color: Colors.black87, fontSize: 20))),
                Spacer(),
              ],
            ),
            Column(
              children: [
                RichText(text: TextSpan(text: description.substring(1,8),
                         style: TextStyle(color: Colors.grey, fontSize: 15))),
              ],
            ),
          ],
        ),

      );
}
