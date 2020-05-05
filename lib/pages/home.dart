import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/model/doner.dart';
import 'package:food/pages/donate.dart';
import 'package:food/pages/foodDescription.dart';
import 'package:food/widget/drawer.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Donor>> showDonate() async {
    var url = 'http://foodshareriju.000webhostapp.com/apps/donate_report.php';
    var response = await http.get(url);
    var jsonData = json.decode(response.body);
    List<Donor> donors = [];
    for (var d in jsonData) {
      Donor donor = new Donor(
        fullname: d['fullname'],
        contact: d['contact'],
        qty: d['qty'],
        address: d['address'],
        image: d['image'],
        food: d['food'],
        description: d['description'],
        status: d['status'],
        sn: d['sn'],
      );
      donors.add(donor);
    }
    return donors;
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      showDonate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Donate()));
            },
            child: Icon(Icons.share),
          ),
          drawer: myDrawer(context),
          appBar: AppBar(
            title: Text('Food Sharing'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.notifications), onPressed: () {})
            ],
          ),
          body: FutureBuilder(
            future: showDonate(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var myData = snapshot.data[index];
                    print(myData.image);
                    print(snapshot.data.length);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: myData.sn,
                                                      child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'http://foodshareriju.000webhostapp.com/apps/${myData.image.toString()}'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black12, Colors.black26],
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  myData.food,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  myData.address,
                                  style: TextStyle(color: Colors.white70),
                                ),
                                trailing: MaterialButton(
                                  textColor: Colors.lightGreen,
                                 onPressed: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDescription(myData: myData,)));
                                 },
                                 child: Text('Request'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.lightGreen,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text('Status',style: TextStyle(fontSize: 10),),
                                  Text(myData.status,style: TextStyle(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.orange
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text('Available for',style: TextStyle(fontSize: 10),),
                                  Text(myData.qty,style: TextStyle(fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
