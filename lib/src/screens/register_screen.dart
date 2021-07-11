import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/screens/home_screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: Image.asset(
                      'images/takemichi_cry.jpg',
                      width: 300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                    child: Center(
                      child: Text(
                        'SIGN UP! ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                    child: Center(
                      child: Text(
                        'Please fill out the information below',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 30, 8, 0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      decoration: InputDecoration(
                          prefixIcon: Container(
                              child: new Image.asset(
                            'images/username_icon.png',
                            width: 50,
                          )),
                          fillColor: Colors.black,
                          hintText: 'Enter Full Name',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          labelText: 'Full Name',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      decoration: InputDecoration(
                          prefixIcon: Container(
                              child: new Image.asset(
                            'images/email_icon.png',
                            width: 50,
                          )),
                          fillColor: Colors.black,
                          hintText: 'Enter Email',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      decoration: InputDecoration(
                          prefixIcon: Container(
                              child: new Image.asset(
                            'images/phonenumber_icon.png',
                            width: 50,
                          )),
                          fillColor: Colors.black,
                          hintText: 'Enter Phone Number',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          labelText: 'Phone Number',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      decoration: InputDecoration(
                          prefixIcon: Container(
                              child: new Image.asset(
                            'images/pass_icon.png',
                            width: 50,
                          )),
                          fillColor: Colors.black,
                          hintText: 'Enter Password',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      decoration: InputDecoration(
                          prefixIcon: Container(
                              child: new Image.asset(
                            'images/pass_icon.png',
                            width: 50,
                          )),
                          fillColor: Colors.black,
                          hintText: 'Re-Enter Password',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          labelText: 'Re-Password',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1))),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.orange,
                        ),
                        child: TextButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Home())),
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )),
                ]),
          ),
        ));
  }
}
