 import 'package:flutter/material.dart';
 import 'package:flutter/widgets.dart';
Row heading(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/logo.jpg'),
                        fit: BoxFit.contain),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Share Meals',
                        textScaleFactor: 2,
                      ),
                      Text('building stronger communities through sharing food',style: TextStyle(color: Colors.blueGrey),),
                      
                    ],
                  ),
                )
              ],
            );
  }

