import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/constants/Constants.dart';

import 'LoginScreen.dart';

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
  String email;
  String username;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
    getCurrentUser();
    // messagesStream();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedinUser = user;
        setState(() {
          username = _loggedinUser.displayName;
          email = _loggedinUser.email;
        });
      }
    } catch (error) {
        EdgeAlert.show(context,
        title:"something went Wrong",
        description: error.toString(),
        gravity: EdgeAlert.BOTTOM,
        icon:Icons.error,
        backgroundColor: Colors.deepPurple[100]);
    }
  }

  void saveMessage(String imageUrl) {
    _firebaseStore.collection('messages').add({
      'sender': 'username',
      'text': _messageText,
      'senderEmail': email,
      'imageUrl': imageUrl,
      'timestamp': DateTime
          .now()
          .microsecondsSinceEpoch
    });
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
        iconTheme: IconThemeData(color: Colors.deepPurple),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(25, 10),
          child: Container(
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.blue,
            ),
            constraints: BoxConstraints.expand(height: 1),
          ),
        ),
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Converse',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.deepPurple),
            ),
            Text(
              'By ABX xyz',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  color: Colors.deepPurple),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('accountName'),
              accountEmail: Text('accountEmail'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png'
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              subtitle: Text('Sign out of this account'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()), (
                    route) => false);
              },
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MessageStream(),
           /* Container(
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
            ),*/
            Container(
              padding: EdgeInsets.only(bottom: 12, top: 0),
              decoration: kMessageContainerDecoration,
              child: Row(
                children: [
                  Container(
                      width: 32,
                      child: IconButton(
                        icon: Icon(
                          Icons.image,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () {},
                      )),
                  SizedBox(width: 10,),
                  Container(
                      width: 32,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () {},
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  //TextField
                  Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 1, bottom: 1,),
                          child: TextField(
                            controller: textEditingController,
                            decoration: kMessageTextFieldDecoration,
                            onChanged: (value) {
                              _messageText = value;
                            },
                          ),
                        ),
                      )
                  ),
                  MaterialButton(
                    shape: CircleBorder(),
                    color: Colors.blue,
                    onPressed: (){
                      textEditingController.clear();
                      saveMessage(null);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
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
            ;
            return Expanded(
              child: ListView(
                reverse: true,
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
