import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/home/datatile.dart';

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {

 @override
  Widget build(BuildContext context) {

   final datalist = Provider.of<List<DispData>>(context) ?? [];

   return SafeArea(
       child: ListView.builder(
           itemCount: datalist.length,
           primary: false,
           shrinkWrap: true,
           itemBuilder: (context, index) {
             return DataTile(dbData: datalist[index]);
           }
       ),
   );
   }
}
