import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _controllerFullname = TextEditingController();
  TextEditingController _controllerContact = TextEditingController();
  TextEditingController _controllerQty = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerFoodName = TextEditingController();
  TextEditingController _controllerFoodDescription = TextEditingController();
  
  Future<File> file;
  String base64Image;
  String tempFile;
  String name;

  void donateIt(String imageName) {
    var url = 'http://foodshareriju.000webhostapp.com/apps/donate.php';

    http.post(url, body: {
      'fullname': _controllerFullname.text,
      'contact': _controllerContact.text,
      'qty': _controllerQty.text,
      'address': _controllerAddress.text,
      'name': imageName,
      'image': base64Image,
      'foodName' : _controllerFoodName.text,
      'foodDescription' : _controllerFoodDescription.text
    });
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot != null) {
          tempFile = snapshot.data.toString();
          base64Image = base64Encode(snapshot.data.readAsBytesSync());

          return Container(
              height: 100,
              child: Image.file(
                snapshot.data,
                fit: BoxFit.fill,
              ));
        } else if (snapshot.error != null) {
          return Text('Error Picking Image');
        } else {
          return Text('No Image Selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Food'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _controllerFullname,
                  decoration: InputDecoration(
                    hintText: 'Your Fullname',
                    labelText: 'Fullname',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your fullname';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _controllerContact,
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    labelText: 'Contact',
                    prefixIcon: Icon(Icons.contact_phone),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Contact Number';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _controllerQty,
                  decoration: InputDecoration(
                    hintText: 'Enough to feed minimum 1 Person',
                    labelText: 'Quantity',
                    prefixIcon: Icon(Icons.confirmation_number),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enough to feed minimum 1 Person';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _controllerAddress,
                  decoration: InputDecoration(
                    hintText: 'Your Full Address',
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your full address';
                    } else {
                      return null;
                    }
                  },
                ),

                TextFormField(
                  controller: _controllerFoodName,
                  decoration: InputDecoration(
                    hintText: 'Food Name',
                    labelText: 'Food Name',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Food Name';
                    } else {
                      return null;
                    }
                  },
                ),

                 TextFormField(
                  controller: _controllerFoodDescription,
                  decoration: InputDecoration(
                    hintText: 'Short Description for food',
                    labelText: 'Short Description',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Short food description';
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(height: 10,),
                Text('Choose Image'),
                OutlineButton(
                  onPressed: () {
                    chooseImage();
                  },
                  child: Text('Choose Image'),
                ),

                SizedBox(
                  height: 10,
                ),
                //! Show Image
                showImage(),

                MaterialButton(
                  color: Colors.lightGreen,
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      setState(() {
                        name = tempFile.split("/").last.toString();
                        //! God single quote at last character in image so need to replace it
                        name = name.substring(0, name.length - 1);
                      });
                      
                      donateIt(name);
                      Toast.show("Thank you for Donating", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                      print('thnk you');
                      print(name);
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
