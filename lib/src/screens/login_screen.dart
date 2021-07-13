import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/src/screens/home_screen.dart';
import 'package:flutter_application_5/src/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState(); 
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePswController = TextEditingController();
  String? email;
  String? password;

  tapLoginButton() async {
    if (_formkey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        )),
        barrierColor: Colors.grey.shade100,
        barrierDismissible: false,
      );

      final _auth = FirebaseAuth.instance;
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
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
                      'images/takemichi.jpg',
                      width: 300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                    child: Center(
                      child: Text(
                        'WELCOME BACK! ',
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
                        'Login to countinue using App',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 40, 8, 0),
                    child: TextFormField(
                      controller: _emailController,
                      onChanged: (val) {
                        email = val.trim();
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
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: TextFormField(
                      onChanged: (val) {
                        password = val.trim();
                      },
                      controller: _retypePswController,
                      validator: (val) => val!.trim().length < 0
                          ? 'Mật khẩu phải ít nhất 6 kí tự!'
                          : null,
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
                  Container(
                    constraints:
                        BoxConstraints.loose(Size(double.infinity, 40)),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontStyle: FontStyle.italic,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.orange,
                        ),
                        child: TextButton(
                            onPressed: () => tapLoginButton(),
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                    child: RichText(
                        text: TextSpan(
                            text: 'New User?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontStyle: FontStyle.italic),
                            children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Register())),
                              text: ' Sign up a new account!',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15.0,
                                  fontStyle: FontStyle.italic))
                        ])),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.orange),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          color: Colors.white, 
                        ),
                        child: TextButton(
                            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Home()),(route)=> false),
                            child: Row(
                              children: [
                                Expanded(
                                    child:
                                        Image.asset('images/google_logo.png')),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.orange),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          color: Colors.white,
                        ),
                        child: TextButton(
                            onPressed: () => print('TTT'),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Image.asset(
                                        'images/facebook_icon.png')),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Sign in with Facebook',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}
