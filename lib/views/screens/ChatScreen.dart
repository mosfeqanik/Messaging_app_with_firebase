import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/constants/Constants.dart';

final _firebaseStore = FirebaseFirestore.instance;
User _loggedinUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String _messageText;
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
    getCurrentUser();
    // messagesStream();
  }

  getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      _loggedinUser = user;
    }
  }

  // void messagesStream() async {
  //   await for (var snapshot in _firebaseStore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        _messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firebaseStore.collection('messages').add({
                        'text': _messageText,
                        'sender': _loggedinUser.email
                      });
                      textEditingController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final messageText;
  final sender;
  final bool isme;

  MessageBubble({this.messageText, this.sender, this.isme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment:
              isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '$sender',
              style: TextStyle(
                  color: isme ? Colors.white : Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w900),
            ),
            Material(
              elevation: 5,
              borderRadius: isme
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      // topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      // topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: isme ? Colors.lightBlue : Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  '$messageText',
                  style: TextStyle(
                      fontSize: 15, color: isme ? Colors.white : Colors.black),
                ),
              ),
            )
          ]),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firebaseStore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data.docs.reversed;
            List<MessageBubble> listMessagesWidget = [];
            for (var message in messages) {
              final messageText = message.get('text');
              final sender = message.get('sender');
              final bool isme = (sender == _loggedinUser.email) ? true : false;
              final messageWidget = MessageBubble(
                messageText: messageText,
                sender: sender,
                isme: isme,
              );
              listMessagesWidget.add(messageWidget);
            }
            return Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: listMessagesWidget,
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
