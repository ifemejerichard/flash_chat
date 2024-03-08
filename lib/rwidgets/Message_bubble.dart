import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:intl/intl.dart';

class Messagebubble extends StatelessWidget {

  final String messageTextinfo;
  final String messageSenderinfo;
  final bool isMe;
  final Timestamp inputdateTime;

  const Messagebubble({super.key, required this.messageTextinfo, required this.messageSenderinfo, required this.isMe, required this.inputdateTime});

  double? checking () { // the ? means that checking is allowed to be null
    if (messageTextinfo.length > 25) {
      return 230;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(messageSenderinfo, style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Container(
              width: checking(),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: isMe ? Colors.lightBlue : Colors.white,
                borderRadius: isMe ? KLoggedinUser : KDiffUser, // this will change based on weather isMe = true or false
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    offset: Offset(1, 2), // Shadow position
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(messageTextinfo,
                    textAlign: isMe ? TextAlign.left : TextAlign.right,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  Text('${DateFormat(' hh:mm').format(inputdateTime.toDate())}',
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
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