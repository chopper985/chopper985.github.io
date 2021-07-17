import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({Key? key}) : super(key: key);

  @override
  _CreateTodoScreenState createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  DateTime selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final _formKey = GlobalKey<FormState>();
  final _mess = GlobalKey<ScaffoldState>();

  TextEditingController _selectedDateController = TextEditingController();

  String title = "TTT";
  String subTitle = "Chú bé chiến trận";
  String imageTodo =
      'https://firebasestorage.googleapis.com/v0/b/make-an-appointment-415cc.appspot.com/o/onepiece.jpg?alt=media&token=8e3d93cb-b33e-477a-b42b-3beffa683bda';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDateController.text = _dateFormat.format(this.selectedDate);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _selectedDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
                      child: InkWell(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/ocsen.gif',
                          image: imageTodo,
                          width: 200,
                          height: 250,
                        ),
                        onTap: () => uploadImage(),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 75, 5, 0),
                      child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              title = text.trim();
                            });
                          },
                          validator: (text) => text!.trim().length < 0
                              ? 'Vui lòng điền title'
                              : null,
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
                                  BorderSide(color: Colors.orange, width: 2),
                            ),
                          ))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
                      child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              subTitle = text.trim();
                            });
                          },
                          validator: (text) => text!.trim().length < 0
                              ? 'Vui lòng điền SubTitle'
                              : null,
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
                                  BorderSide(color: Colors.orange, width: 2),
                            ),
                          ))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 5, 0),
                      child: TextField(
                          controller: _selectedDateController,
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            labelText: "Time",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 2),
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
                                    final selectedTime =
                                        await _selectTime(context);
                                    setState(() {
                                      this.selectedDate = DateTime(
                                          selectedDate!.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime!.hour,
                                          selectedTime.minute);
                                      _selectedDateController.text =
                                          _dateFormat.format(this.selectedDate);
                                    });
                                  }),
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
                              .collection('todos')
                              .add({
                            "title": title,
                            "subTitle": subTitle,
                            "status": 'DOING',
                            "createAt": this.selectedDate,
                            "image": imageTodo,
                            "userId": FirebaseAuth.instance.currentUser!.uid,
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        color: Colors.lightBlue,
                        splashColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          'Add Tast',
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
    String imagefilename =
        DateTime.now().toString() + FirebaseAuth.instance.currentUser!.uid;
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
        var snapshot = await fireStorage
            .ref()
            .child('Notification')
            .child(imagefilename)
            .putFile(file);
        var download = await snapshot.ref.getDownloadURL();
        setState(() {
          imageTodo = download;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permission and try again');
    }
  }
}
