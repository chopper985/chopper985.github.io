import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/model/todo.dart';



class TodoCart extends StatefulWidget {
  final data;
  final index;
  TodoCart({required this.data, required this.index});
  @override
  State<StatefulWidget> createState() => _TodoCartState();
}

class _TodoCartState extends State<TodoCart> {
  Todo? todo;

  @override
  void initState() {
    super.initState();
    todo = Todo.fromFirestore(widget.data);
  }

  cancelTask() async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      margin: EdgeInsets.fromLTRB(10, 0, 5, 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange,width: 2),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      padding: EdgeInsets.only(left:8.0, right: 8.0),
      child: Row(
        children: [
          Expanded(
            child: FadeInImage.assetNetwork(
              placeholder: 'images/ocsen.gif',
              image: todo!.image,
              width: 60,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  todo!.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  todo!.subTitle,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 18.0,
                color: Colors.red,
              ),
              onPressed: () => cancelTask(),
            ),
          ),
        ],
      ),
    );
  }
}
