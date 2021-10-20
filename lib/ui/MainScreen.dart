import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelist/data/DataGenerator.dart';
import 'package:travelist/model/TravelList.dart';

import 'DetailInformation.dart';

class MainScreen extends StatefulWidget {
  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<MainScreen> {
  TextEditingController controller = new TextEditingController();

  List<TravelList> _travelList = [];

  @override
  void initState() {
    _travelList = travelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Column(children: <Widget>[
      Container(
        color: Theme.of(context).primaryColor,
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Card(
            child: new ListTile(
              leading: new Icon(Icons.search),
              title: new TextField(
                controller: controller,
                decoration: new InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                onChanged: (value) => filterList(value),
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  controller.clear();
                  this.setState(() {
                    _travelList = travelList;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: _travelList.length > 0
            ? ListView.builder(
                itemCount: _travelList.length,
                itemBuilder: (context, index) {
                  var travelList = _travelList[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailInformation(
                            travelList: travelList,
                          );
                        }));
                      },
                      child: Row(children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              ),
                              child: Image.network(
                                travelList.imgURL,
                                width: 200,
                                height: 85,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                travelList.title,
                                style: TextStyle(fontSize: 22),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Chip(
                                  avatar: Icon(Icons.map),
                                  label: Text(travelList.location))
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
                })
            : Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
      )
    ]));
  }

  void filterList(String filterText) {
    List<TravelList> result = [];

    if (filterText.isEmpty) {
      result = travelList;
    } else {
      _travelList = travelList;
      result = _travelList
          .where((element) =>
              element.title.toLowerCase().contains(filterText.toLowerCase()))
          .toList();
    }

    this.setState(() {
      _travelList = result;
    });
  }
}
