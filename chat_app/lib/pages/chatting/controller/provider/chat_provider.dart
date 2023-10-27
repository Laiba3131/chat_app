import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/chat_model.dart';
import '../../resource/app_images.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> listOfChatModel = [
    ChatModel(
        isRead: false,
        userImage: AppImages.dummyImage,
        userName: "Ross Galler",
        time: DateTime.now()),
    ChatModel(
        isRead: true,
        userImage: AppImages.dummyImage,
        userName: "Alexander A.",
        time: DateTime.now()),
    ChatModel(
        isRead: true,
        userImage: AppImages.dummyImage,
        userName: "William M.",
        time: DateTime.now()),
  ];

  List<ChatMessageModel> chatMessageList = [
    ChatMessageModel(
        time: DateTime.now(),
        message: "Hello!",
        isReceiver: false,
        // isOffer: false,
        // price: 0,
        title: ""),
    ChatMessageModel(
        time: DateTime.now(),
        message: "How are you?",
        isReceiver: true,
        // isOffer: false,
        // price: 0,
        title: ""),
    ChatMessageModel(
        time: DateTime.now(),
        message: "How are you?",
        isReceiver: true,
        // isOffer: false,
        // price: 0,
        title: ""),
    ChatMessageModel(
        time: DateTime.now(),
        message: "I am waiting.",
        isReceiver: false,
        // isOffer: true,
        // price: 20,
        title: "test"),
    ChatMessageModel(
        time: DateTime.now(),
        message: "I am waiting for your response,..",
        isReceiver: false,
        // isOffer: false,
        // price: 0,
        title: ""),
  ];

  //instance of auth

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

// add a new document for a user if does not already exist
      _firestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email},
          SetOptions(merge: true));

      return userCredential;
    }

    // catch any errors

    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign user out

  Future<UserCredential> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

// after creating the user add document for the user in user collection
      _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//Send Message
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //new message

    //Message newMessage= Message()
  }

  void update() {
    notifyListeners();
  }
}
