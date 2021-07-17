import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class EditTodoScreen extends StatefulWidget {
  final index;
  final String title;
  final String subTitle;
  final String imageTodo;
  final Timestamp createAt;
  const EditTodoScreen(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.index,
      required this.imageTodo,
      required this.createAt})
      : super(key: key);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  String title = "TTT";
  String subTitle = "Chú bé chiến trận";
  String? imageTodo;
  // String? timeTodo;
  DateTime selectedDate = DateTime.now();
  DateFormat formatDate = DateFormat('yyyy-MM-dd HH:mm');
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _subTitleController = new TextEditingController();
  TextEditingController _imageTodoController = new TextEditingController();
  TextEditingController _timeTodo = new TextEditingController();

  @override
  void initState() {
    super.initState();
    title = widget.title;
    subTitle = widget.subTitle;
    imageTodo = widget.imageTodo;
    _titleController.text = widget.title;
    _subTitleController.text = widget.subTitle;
    _imageTodoController.text = widget.imageTodo;
    _timeTodo.text = widget.createAt.toDate().toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _subTitleController.dispose();
    _imageTodoController.dispose();
    _timeTodo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
                    child: InkWell(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'images/ocsen.gif',
                        image: _imageTodoController.text,
                        width: 200,
                        height: 250,
                      ),
                      onTap: () => uploadImage(),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 75, 5, 0),
                    child: TextField(
                        controller: _titleController,
                        onChanged: (text) {
                          setState(() {
                            title = text.trim();
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          hintText: "Enter Title",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          labelText: "Title",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                        ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
                    child: TextField(
                        controller: _subTitleController,
                        onChanged: (text) {
                          setState(() {
                            text = _subTitleController.text;
                            subTitle = text.trim();
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          hintText: "Enter Sub Title",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          labelText: "SubTitle",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                        ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
                    child: TextField(
                        controller: _timeTodo,
                        keyboardType: TextInputType.datetime,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          hintText: "Enter Time",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          labelText: "Time",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          prefixIcon: Container(
                            child: IconButton(
                              icon: Image.asset(
                                'images/date_icon.png',
                                width: 60,
                              ),
                              onPressed: () async {
                                final selectedDate =
                                    await _selectDateTime(context);
                                final selectedTime = await _selectTime(context);
                                setState(() {
                                  this.selectedDate = DateTime(
                                      selectedDate!.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime!.hour,
                                      selectedTime.minute);
                                  _timeTodo.text =
                                      formatDate.format(this.selectedDate);
                                });
                              },
                            ),
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blueAccent),
                          )),
                          barrierColor: Colors.grey.shade100,
                          barrierDismissible: false,
                        );
                        await FirebaseFirestore.instance
                            .runTransaction((transaction) async {
                          transaction.update(widget.index, {
                            "title": title,
                            "subTitle": subTitle,
                            "status": "DOING",
                            "createAt": this.selectedDate,
                            "image": _imageTodoController.text,
                          });
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      color: Colors.lightBlue,
                      splashColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        'Edit Task',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
  }

  Future<DateTime?> _selectDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
  uploadImage() async {
    final fireStorage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    String imagefilename = DateTime.now().toString();
    PickedFile image;

    //Check permission
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _picker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot =
            await fireStorage.ref().child(imagefilename).putFile(file);
        var download = await snapshot.ref.getDownloadURL();
        setState(() {
          _imageTodoController.text = download;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permission and try again');
    }
  }
}
