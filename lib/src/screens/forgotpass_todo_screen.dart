import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? _email;
  GlobalKey _formkey = GlobalKey<State>();

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Forgot Password',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                        child: Image.asset(
                          'images/ASL.jpg',
                          width: 300,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                        child: Center(
                          child: Text(
                            'Reset Password',
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
                            'Please enter your account email',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 60, 8, 0),
                        child: TextFormField(
                          controller: _emailController,
                          onChanged: (val) {
                            _email = val.trim();
                          },
                          validator: (val) => val!.trim().length == 0
                              ? 'Hãy nhập email của bạn!'
                              : null,
                          keyboardType: TextInputType.emailAddress,
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1))),
                        ),
                      ),
                      Padding(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Container(
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.orange,
                        ),
                        child: TextButton(
                            onPressed: () {
                              _auth.sendPasswordResetEmail(email: _email!);
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text(
                                'Send Request',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )),
                    ])))));
  }
}
