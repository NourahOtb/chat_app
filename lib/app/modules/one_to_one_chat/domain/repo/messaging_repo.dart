import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:uuid/uuid.dart';

class MessagingRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String senderId,
    required String recieverId,
    required String message,
  }) async {
    try {
      final chatRoomId = _getChatRoomId(senderId, recieverId);

      DocumentReference messageRef = _firebaseFirestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('message')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      Message chatMessage = Message(
        messageId: const Uuid().v4(),
        recieverId: recieverId,
        senderId: senderId,
        message: message,
        timeStamp: DateTime.now(),
      );

      await messageRef.set(chatMessage.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  /// to create a common chat room id between two users
  _getChatRoomId(String senderId, String recieverId) {
    return senderId.hashCode <= recieverId.hashCode
        ? '$senderId-$recieverId'
        : '$recieverId-$senderId';
  }

  Stream<List<Message>> getAllMessage({
    required String senderId,
    required String recieverId,
  }) {
    final chatRoomId = _getChatRoomId(senderId, recieverId);

    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        _firebaseFirestore
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('message')
            .orderBy('timeStamp', descending: true)
            .snapshots();

    return snapshot.map((querySnapshot) => querySnapshot.docs.map((document) {
          final data = document.data();

          DateTime dateTime = data['timeStamp'] is int
              ? DateTime.fromMillisecondsSinceEpoch(data['timeStamp'])
              : data['timeStamp'] as DateTime;

          return Message(
            messageId: document.id,
            recieverId: data['recieverId'],
            senderId: data['senderId'],
            message: data['message'],
            timeStamp: dateTime,
          );
        }).toList());
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/models/message.dart';
// import 'package:uuid/uuid.dart';

// class MessagingRepo {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   Future<void> sendMessage({
//     required String senderId,
//     required String receiverId,
//     required String message,
//   }) async {
//     try {
//       String chatRoomId = _getChatRoomId(senderId, receiverId);

//       DocumentReference documentReference = _firebaseFirestore
//           .collection('chat_rooms')
//           .doc(chatRoomId)
//           .collection('messages')
//           .doc(DateTime.now().millisecondsSinceEpoch.toString());

//       Message messageChat = Message(
//         senderId: senderId,
//         message: message,
//         timeStamp: DateTime.now(),
//         messageId: const Uuid().v4(),
//         receieverId: receiverId,
//       );

//       await documentReference.set(messageChat.toMap());
//     } catch (e) {
//       throw ('Error sending message: $e');
//     }
//   }

//   _getChatRoomId(String senderId, String recieverId) {
//     return senderId.hashCode < recieverId.hashCode
//         ? '$senderId-$recieverId'
//         : '$recieverId-$senderId';
//   }

// // Retrieve messages between two users
//   Stream<List<Message>> messagesStream({
//     required String senderId,
//     required String receiverId,
//   }) {
//     try {
//       String chatRoomId = _getChatRoomId(senderId, receiverId);

//       final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
//           _firebaseFirestore
//               .collection('chat_rooms')
//               .doc(chatRoomId)
//               .collection('messages')
//               .orderBy('timestamp', descending: true)
//               .snapshots();

//       return snapshot.map((querySnapshot) => querySnapshot.docs.map((doc) {
//             final data = doc.data();

//             DateTime timestamp = data['timestamp'] is int
//                 ? DateTime.fromMillisecondsSinceEpoch(data['timestamp'] as int)
//                 : data['timestamp'] as DateTime;

//             return Message(
//               messageId: doc.id,
//               senderId: data['senderId'],
//               receieverId: data['receiverId'],
//               message: data['message'],
//               timeStamp: timestamp,
//             );
//           }).toList());
//     } catch (e) {
//       throw ('Error fetching messages: $e');
//     }
//   }
// }
