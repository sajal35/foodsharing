import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/pages/home.dart';
import 'package:food/pages/signup.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String message = "";

  Future<List> loginUser() async {
    String url = 'http://foodshareriju.000webhostapp.com/apps/login.php';
    final response = await http.post(url,
        body: {'username': username.text, 'password': password.text});

    var datauser = json.decode(response.body);
    if (datauser.length == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      setState(() {
        message = "invalid username or password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Food Sharing',
                        textScaleFactor: 2,
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Feed the Need',
                        style: TextStyle(color: Colors.blueGrey),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(142, 152, 205, .3),
                            offset: Offset(0, 2),
                            blurRadius: 5),
                      ]),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Username',
                              prefixIcon: Icon(Icons.person)),
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.lightGreen,
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        loginUser();
                      }
                    },
                    child: Text('Login'),
                  ),
                ),
                Text(
                  "$message",
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "if you don't have an account please sign up here",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text('Sign Up'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
