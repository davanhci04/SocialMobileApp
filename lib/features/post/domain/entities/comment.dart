import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String postId;
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
  });

  Comment copyWith({String? imageUrl}) {
    return Comment(
      id: id,//commentID
      postId: postId,
      userId: userId,
      userName: userName,
      text: text,
      timestamp: timestamp,//Thoi gian comment
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'name': userName,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      userName: json['name'],
      text: json['text'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}
