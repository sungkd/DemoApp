import 'package:flutter/material.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/screens/mydatatile.dart';
import 'package:provider/provider.dart';

class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  @override
  Widget build(BuildContext context) {

    final datalist = Provider.of<List<DispData>>(context) ?? [];


    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: datalist.length,
                itemBuilder: (context, index) {
                  return MyDataTile(dbData: datalist[index]);
                }
            ),
          ),
        ],
      ),
    );
  }
}

