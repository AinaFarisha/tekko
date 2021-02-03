import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  Timestamp accountCreated;
  String fullName;
  String groupId; //admin of group id
  List<String> memberOfGroup; //list of joined and leads group
  
   UserModel({
    this.uid,
    this.email,
    this.accountCreated,
    this.fullName,
    this.groupId,
    this.memberOfGroup, 
  });

}