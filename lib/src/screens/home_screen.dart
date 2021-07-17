import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/repository/user_repository.dart';
import 'package:flutter_application_5/src/screens/login_screen.dart';
import 'package:flutter_application_5/src/widget/todo_cart.dart';
import 'package:flutter_application_5/src/screens/edit_todo_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_todo_screen.dart';

class Home extends StatefulWidget {
  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _message = 'Log in/out by pressing the buttons below.';
  final _auth = FirebaseAuth.instance.currentUser;
  Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  printToken() async {
    String? token = await getFCMToken();
    await UseRepository().addTokenToUser(token!);
    }

  handle() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  
  Future<Login> _signOut() async {
    // final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
        (route) => false);
    return Login();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printToken();
    handle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateTodoScreen())),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tokyo revenger',
          style: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
              onPressed: () => _signOut(),
              icon: Icon(
                Icons.door_back_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('todos')
              .where('status', isEqualTo: 'DOING')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            var data = snapshot.data!.docs;
            return ListView.builder(
                padding: EdgeInsets.only(top: 12.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditTodoScreen(
                          imageTodo: data[index]['image'],
                          index: data[index].reference,
                          title: data[index]['title'],
                          subTitle: data[index]['subTitle'],
                          createAt: data[index]['createAt'],
                        ),
                      ),
                    ),
                    child: TodoCart(
                        index: data[index].reference, data: data[index]),
                  );
                });
          },
        ),
      ),
    );
  }
}
