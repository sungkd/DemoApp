import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/constants/decorate.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailScreen extends StatelessWidget {
  
  final DispData dbData;
  DetailScreen({this.dbData});

  //Function to launch phone dialer
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

    final List<String> imgList = [
      dbData.imgUrl, dbData.imgUrl1, dbData.imgUrl2];
    
    
    String _neutered = '';

    if (dbData.neutered.toString().toLowerCase() == 'true') {
      if(dbData.gender.toLowerCase() == 'male') {
        _neutered = 'Neutered';
      }
      else
        {
          _neutered = 'Spayed';
        }
    }
    else
      {
        _neutered = 'Not Neutered';
      }

    return Scaffold(
      body: Stack(
        children: [
          // Grey and White Background
          Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                      child: Container(color: Colors.blueGrey[300],)
                  ),
                  Expanded(child: Container(color: Colors.white,))
                ],
              )
          ),

          // Top of App
          Container(
            margin: EdgeInsets.only(top: 65),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios),
                    onPressed: () { Navigator.pop(context); }
                  ),
                ],
              ),
            ),
          ),

          //Image of pet
          Container(
            padding: EdgeInsets.fromLTRB(10, 130, 10, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                ),
                items: imgList.map((item) =>
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => CircularProgressIndicator(
                          backgroundColor: Colors.grey[600],
                          strokeWidth: 2,
                        ),
                        imageUrl: item,
                        fit: BoxFit.cover,
                        width: 300,
                        height: 290,
                      ),
                  ),
                    ),
                ).toList(),
              ),
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(15.0),
              //   child: CachedNetworkImage(
              //     placeholder: (context, url) => CircularProgressIndicator(
              //       backgroundColor: Colors.grey[600],
              //       strokeWidth: 2,
              //     ),
              //     imageUrl: dbData.imgUrl,
              //     fit: BoxFit.cover,
              //     width: 300,
              //     height: 270,
              //   ),
              // ),
            ),
          ),

          /*Breed Gender,Location,Age Container*/
          Align(
            child: Container(
              height: 170,
              margin: EdgeInsets.fromLTRB(10,100,10,0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(10,20,10, 0),
                child: Column(
                  children: [
                    //Breed and Gender
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text: TextSpan(
                            text: dbData.breed,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20.0,
                            )
                        )
                        ),
                        (dbData.gender.toLowerCase() == 'male') ?
                          Icon(LineIcons.mars, size: 25.0,
                          color: Colors.red[600],)
                        : Icon(LineIcons.venus, size: 25.0,
                               color: Colors.pink[600],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    //Neutered and Age
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text: TextSpan(
                                 text: _neutered,
                                 style: TextStyle(
                                 color: Colors.grey[600], fontSize: 15.0,))
                            ),

                        RichText(text: TextSpan(text: dbData.age.toString()
                            + ' ' + dbData.days,
                            style: TextStyle(
                              color: Colors.grey[600], fontSize: 15.0,))
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    //Area
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(LineIcons.mapMarker, color: Colors.red[800],
                        size: 15,),
                        SizedBox(width: 3,),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            RichText(text: TextSpan(
                                text: dbData.area,
                                style: TextStyle(
                                  color: Colors.grey[600], fontSize: 15.0,))
                            ),
                          ]
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    //Location and Pin Code
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        RichText(
                          text: TextSpan(
                            text: dbData.location + ' - ' +
                                  dbData.pin.toString(),
                          style: TextStyle(
                            color: Colors.grey[600], fontSize: 15.0,
                          ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        RichText(
                          text: TextSpan(
                            text: 'Posted on: ',
                            style: TextStyle(
                              color: Colors.grey[600], fontSize: 15.0,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: dbData.dateTime.toString(),
                            style: TextStyle(
                              color: Colors.grey[600], fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          /*Middle Section to display Description*/
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: EdgeInsets.fromLTRB(15, 540, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: dbData.description,
                          style: TextStyle(fontSize: 15.0, letterSpacing: 1.0,
                                  wordSpacing: 1.0, color: Colors.black87) ,
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


          /*Bottom Container*/
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(color: Colors.teal[900],
                        borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextButton.icon(
                              onPressed: () {
                                _launchCaller(dbData.phone);
                              },
                              icon: Icon(LineIcons.phone,
                              color: Colors.white,),
                              label: RichText(
                                text: TextSpan(text: dbData.name,
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 18.0,),),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




