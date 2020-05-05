import 'package:flutter/material.dart';

class FoodDescription extends StatefulWidget {
  final myData;
  FoodDescription({this.myData});
  @override
  _FoodDescriptionState createState() => _FoodDescriptionState();
}

class _FoodDescriptionState extends State<FoodDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
              child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: widget.myData.sn,
                child: Expanded(
                                child: Image.network(
                      'http://foodshareriju.000webhostapp.com/apps/${widget.myData.image}'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text(
                        widget.myData.food,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      
                          Text(widget.myData.description)
                        ],
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text('Donor Information',textScaleFactor: 1.5,),
                     ),
                     ListTile(
                       title: Text(widget.myData.fullname),
                       subtitle: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text(widget.myData.contact),
                               Text(widget.myData.address),
                         ],
                       ),
                     )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
