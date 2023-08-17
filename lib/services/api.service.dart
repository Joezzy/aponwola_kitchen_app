

import 'dart:developer';
import 'dart:io';

import 'package:aponwola/data/CurrentUser.dart';
import 'package:aponwola/data/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ApiService {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;
  // to return current user
  static User get user => auth.currentUser!;

  // // for storing self information
  static CurrentUser me=CurrentUser();

  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static Future<void> createProduct(Product product,File file) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    return await firestore.collection('products')
        .doc("user.uid")
        .set(product.toJson());
  }

  Future <List<Product>> getProduct() async{
    final prod= await firestore
        .collection("products")
        .orderBy('sent', descending: true)
        .get();
    List<Product> list= prod.docs.map((doc) => Product.fromSnapShot(doc)).toList();
    return list;

  }

  // for getting firebase messaging token
  // static Future<void> getFirebaseMessagingToken() async {
  //   await fMessaging.requestPermission();
  //
  //   await fMessaging.getToken().then((t) {
  //     if (t != null) {
  //       me.pushToken = t;
  //       log('Push Token: $t');
  //     }
  //   });
  //
  //   // for handling foreground messages
  //   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   //   log('Got a message whilst in the foreground!');
  //   //   log('Message data: ${message.data}');
  //
  //   //   if (message.notification != null) {
  //   //     log('Message also contained a notification: ${message.notification}');
  //   //   }
  //   // });
  // }

  // for sending push notification
  // static Future<void> sendPushNotification(
  //     CurrentUser CurrentUser, String msg) async {
  //   try {
  //     final body = {
  //       "to": CurrentUser.pushToken,
  //       "notification": {
  //         "title": me.name, //our name should be send
  //         "body": msg,
  //         "android_channel_id": "chats"
  //       },
  //       // "data": {
  //       //   "some_data": "User ID: ${me.id}",
  //       // },
  //     };
  //
  //     var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json',
  //           HttpHeaders.authorizationHeader:
  //           'key=AAAAQ0Bf7ZA:APA91bGd5IN5v43yedFDo86WiSuyTERjmlr4tyekbw_YW6JrdLFblZcbHdgjDmogWLJ7VD65KGgVbETS0Px7LnKk8NdAz4Z-AsHRp9WoVfArA5cNpfMKcjh_MQI-z96XQk5oIDUwx8D1'
  //         },
  //         body: jsonEncode(body));
  //     log('Response status: ${res.statusCode}');
  //     log('Response body: ${res.body}');
  //   } catch (e) {
  //     log('\nsendPushNotificationE: $e');
  //   }
  // }

  // for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for adding an chat user for our conversation

  // for getting current user info
  static Future<dynamic> getSelfInfo() async {
    DocumentSnapshot<Map<String, dynamic>> userData=  await firestore.collection('users').doc(user.uid).get();
    if (userData.exists) {
        return CurrentUser.fromJson(userData.data()!);
        }
   return ;
    //     .then((user) async {
    //   if (user.exists) {
    //    me= CurrentUser.fromJson(user.data()!);
    //     log('My Data: ${user.data()}');
    //   } else {
    //     print("NO_IINFO");
    //     // return await createUser().then((value) => getSelfInfo());
    //   }
    // });
  }

  // for creating a new user
  static Future<void> createUser(
      email,
      name,
      ) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final currentUser = CurrentUser(
        id: user.uid,
        name: name,
        email: email,
        address: "",
        image: "",
        createdAt: time,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(currentUser.toJson());
  }

  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return firestore
        .collection('users')
        .where('id',
        whereIn: userIds.isEmpty
            ? ['']
            : userIds) //because empty list throws an error
    // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }


  // for adding an user to my user when first message is send
  // static Future<void> sendFirstMessage(
  //     CurrentUser CurrentUser, String msg, Type type) async {
  //   await firestore
  //       .collection('users')
  //       .doc(CurrentUser.id)
  //       .collection('my_users')
  //       .doc(user.uid)
  //       .set({}).then((value) => sendMessage(CurrentUser, msg, type));
  // }

  // for updating user information
  static Future<void> updateUserInfo(
      name,
      phone,
      ) async {
    await firestore.collection('users').doc(user.uid).update({
      'name': name,
      'phone': phone,
    });
  }


  // update profile picture of user
  // static Future<void> updateProfilePicture(File file) async {
  //   //getting image file extension
  //   final ext = file.path.split('.').last;
  //   log('Extension: $ext');
  //   //storage file ref with path
  //   final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
  //   //uploading image
  //   await ref
  //       .putFile(file, SettableMetadata(contentType: 'image/$ext'))
  //       .then((p0) {
  //     log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
  //   });
  //
  //   var image = await ref.getDownloadURL();
  //   await firestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .update({'image': image});
  // }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      CurrentUser currentUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: currentUser.id)
        .snapshots();
  }

  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  ///************** Chat Screen Related APIs **************

  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  // useful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      CurrentUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id!)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }


 static Future updateProfilePicture( Uint8List file)async{
    Reference ref=storage.ref().child(user.uid);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl= await snapshot.ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': downloadUrl});
  }

}
