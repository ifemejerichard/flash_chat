import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/rwidgets/Message_bubble.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // creating a firestore object.
  final FirebaseAuth _auth = FirebaseAuth.instance; // creating a authentication object
  final messageTextcontroller = TextEditingController(); // this will help us control what happens in the textfield
  late User loggedinUser;
  late String textMessage;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser () {
    try {
      final currentUser = _auth.currentUser; // getting the information of the loggedin user
      if (currentUser != null) {
        loggedinUser = currentUser;
        //print(currentUser);
      }
    }
    catch(error){
      Alert(context: context, title: "TRY AGAIN", desc: '$error',
          style: const AlertStyle(backgroundColor: Colors.black87,
              isButtonVisible: false, titleStyle: kSendButtonTextStyle,
              descStyle: kSendButtonTextStyle)
      ).show();
      return;
    }
  }

  // // this function gets the list of textmessages for the 'messages' in the db
  // // but it has to be triggered manually, meaning messages don't show up unless we call the function
  Future<void> getMessages () async{
    // Get docs from the collection reference which is 'messages'
    final userDocs = await _firestore.collection('messages').get();

    // Get data from userDocs and convert the map to a List
    final userMessages = userDocs.docs.map((doc) => doc.data()).toList();

    // printing each element in the list
    for(var userMessage in userMessages) {
      print(userMessage);
    }
  }

  // this function creates a stream that gets called by the snapshot method
  // when ever data is added to the messages collection in the db
  // which is exactly what we one for our messaging app
  void messagesStream() async{
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var userText in snapshot.docs){
        print(userText.data());
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () async{
                try {
                  await getMessages();
                  //await _auth.signOut();
                  //Navigator.pop(context);
                }
                catch(e){
                  print(e);
                }
              }),
        ],
        title: const Text('⚡️Chat', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>( // this will help us display the stream of messages
                stream: _firestore.collection('messages').orderBy('time', descending: true).snapshots(), // this gets the stream from the db
                builder: (context, snapshot){

                  if (snapshot.hasData){
                    final messages = snapshot.data?.docs ?? []; // .reversed means the doc should be reversed from bottom to top
                    // the ? is checking if snapshot.data is not null and if it isn't then we add the .docs method we could also use('!' instead of '?')
                    // snapshot contains a querysnapshot from firebase and the .date gets or accesses the latest
                    // data received by the asyncsnapshot and the .document creates a list out of those data
                    List <Widget> messageBubbles = [];

                    print(messages);
                    for (var message in messages){
                      final currentUser = loggedinUser.email;
                      final messageText = message.get('text');
                      final messageSender = message.get('sender');
                      final currentTime = message.get('time');

                      final messageBubble = Messagebubble(
                        messageTextinfo: messageText,
                        messageSenderinfo: messageSender,
                        isMe: (currentUser == messageSender), // this will return true if CU == MS, and false if not
                        inputdateTime: currentTime,
                      );
                      messageBubbles.add(messageBubble);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        children: messageBubbles,
                      ),
                    );
                  }
                 else{
                   return const SpinKitCircle(color: Colors.white, size: 100); // loading indicator
                  }
                },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: messageTextcontroller,
                      onChanged: (value) {
                        textMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      var dateTime = DateTime.now();
                      try {
                        _firestore.collection('messages').add({'text': textMessage, 'sender': loggedinUser.email, 'time' : dateTime});
                      }
                      catch(error){
                        Alert(context: context, title: "TRY AGAIN", desc: '$error',
                            style: const AlertStyle(backgroundColor: Colors.black87,
                                isButtonVisible: false, titleStyle: kSendButtonTextStyle,
                                descStyle: kSendButtonTextStyle)
                        ).show();
                        return;
                      }
                      messageTextcontroller.clear();// this will clear the message from the textfield after it has been sent
                    },
                    child: const Text(
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
