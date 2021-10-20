import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelist/core/CoreHelper.dart';
import 'package:travelist/model/TravelList.dart';

class DetailInformation extends StatelessWidget {
  final TravelList travelList;

  DetailInformation({required this.travelList});

  @override
  Widget build(BuildContext context) {
    var width85 = MediaQuery.of(context).size.width * 85 / 100;
    return Scaffold(
        appBar: AppBar(
          title: Text(travelList.title),
        ),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.network(
                        travelList.imgURL,
                        width: width85, // 85 % of available screen width
                        height: 285,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          travelList.title,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Staatliches',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          CoreHelper.launchURL(
                              "http://maps.google.com/?q=${travelList.location}");
                        },
                        child: Chip(
                            avatar: Icon(Icons.map),
                            label: Text(travelList.location)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        width: width85,
                        child: Text(
                          travelList.description,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
