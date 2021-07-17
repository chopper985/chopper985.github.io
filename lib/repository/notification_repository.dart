import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepoditory {
  addNotification({title, body, urlToImage, date}) async {
    FirebaseFirestore.instance.collection('notification').add({
      'title': title,
      'body': body,
      'image': urlToImage,
      'date': date,
    });
  }

  editNotidication({title, body, urlToImage, date, index}) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(index, {
        'title': title,
        'body': body,
        'image': urlToImage,
        'date': date,
      });
    });
  }
  
}
