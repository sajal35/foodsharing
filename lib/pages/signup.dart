// import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food/pages/login.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<File> file;
  String base64Image;
  String tempFile;
  String name;

  void registerUser() {
    var url = 'http://foodshareriju.000webhostapp.com/apps/register.php';

    http.post(url, body: {
      'fullname': fullname.text,
      'address': address.text,
      'organization': organization.text,
      'contact': contact.text,
      'username': username.text,
      'password': password.text,
      /* 'image': base64Image,
      'name': imageName */
    });
  }

  /* chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
  } */

  /* showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot != null) {
          tempFile = snapshot.data.toString();
          base64Image = base64Encode(snapshot.data.readAsBytesSync());

          return Container(
              height: 100,
              color: Colors.red,
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
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _globalKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(
                        hintText: 'Fullname',
                        labelText: 'Enter your fullname',
                        prefixIcon: Icon(Icons.info)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter fullname';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                        hintText: 'Address',
                        labelText: 'Enter your address',
                        prefixIcon: Icon(Icons.location_city)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: organization,
                    decoration: InputDecoration(
                        hintText: 'Organization/Personal',
                        labelText: 'Enter your organization',
                        prefixIcon: Icon(Icons.home)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your organization';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: contact,
                    decoration: InputDecoration(
                        hintText: 'Contact No',
                        labelText: 'Enter your Contact Number',
                        prefixIcon: Icon(Icons.phone)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your contact number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter username';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock)),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your password';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                /*   Text('Choose Image'),
                  OutlineButton(
                    onPressed: () {
                      chooseImage();
                    },
                    child: Text('Choose Profile Image'),
                  ), */
                  SizedBox(
                    height: 10,
                  ),
                  // showImage(),
                  RaisedButton(
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                       /*  setState(() {
                          name = tempFile.split("/").last.toString();
                          //! God single quote at last character in image so need to replace it
                          name = name.substring(0, name.length - 1);
                          print(name);
                        }); */

                        registerUser();
                        Toast.show("Thank you for Registration", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                        print('thnk you');
                        print(fullname.text);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      }
                    },
                    child: Text('Register'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
