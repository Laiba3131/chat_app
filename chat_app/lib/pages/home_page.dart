import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: _buildUserList(),
    );
  }

  //Build a list of users

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasError) {
          return const Text("Error");
        }

        if (snapshots.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshots.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  //

  // Widget _buildUserListItem(DocumentOrShadowRoot document) {
  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  //   if (_auth.currentUser!.email != data['email']) {
  //     return ListTile(
  //       title: Text(data['email']),
  //       onTap: () {
  //         push(
  //             context,
  //             ChatPage(
  //               receiveUserEmail: data['email'],
  //               receiveUserId: data['uid'],
  //             ));
  //       },
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  Widget _buildUserListItem(DocumentSnapshot? document) {
    if (document == null || !document.exists) {
      return Container(); // Handle the case where document is null or doesn't exist
    }

    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null ||
        _auth.currentUser!.email == null ||
        data['email'] == null) {
      return Container(); // Handle cases where data or email is null
    }

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          push(
            context,
            ChatPage(
              receiveUserEmail: data['email'],
              receiveUserId: data['uid'],
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
