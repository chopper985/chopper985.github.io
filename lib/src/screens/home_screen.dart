import 'package:flutter/material.dart';
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
        title: Text(
          'Tokyo revenger',
          style: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
              onPressed: () => {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => History())),
                  },
              icon: Icon(
                Icons.calendar_today,
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