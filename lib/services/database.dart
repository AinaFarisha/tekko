import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tekko/models/group.dart';
import 'package:tekko/models/user.dart';

class Database{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference groupCollection = FirebaseFirestore.instance.collection('groups');
  final String uid;
  Database({this.uid});

  Future<String> createUser(UserModel user) async {
    String retVal = "error";

    try{
      await _firestore.collection("users").doc(user.uid).set({
        'fullName' : user.fullName,
        'email' : user.email,
        'accountCreated' : Timestamp.now(),
      });
      return retVal = "success";

    }catch(e){
      print(e);
    }


    return retVal;
  }

  Future<UserModel> getUserInfo(String uid) async {
    UserModel retVal = UserModel();

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data()["fullName"];
      retVal.email = _docSnapshot.data()["email"];
      retVal.accountCreated = _docSnapshot.data()["accountCreated"];
      retVal.groupId = _docSnapshot.data()["groupId"];
      retVal.memberOfGroup = _docSnapshot.data()["memberOfGroup"];

    }catch(e) {
      print(e);
    }

    return retVal;
  }

    Future<String> createGroup(String groupName, String userUid, String groupImg) async {
    String retVal = "error";
    List<String> members = List();
    // List<String> memberOfGroup = List();


    try{
      members.add(userUid);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'groupImg' : groupImg,
        'name' : groupName,
        'leader' : userUid,
        'members' : members,
        'groupCreated' : Timestamp.now(),
      });

      await _firestore.collection("users").doc(userUid).update({
        'groupId' : _docRef.id,
        'memberOfGroup' : _docRef.id, //baru tambah 
      });
      // to add to group document under users document
      DocumentReference _ref2 = _docRef;
      _ref2 = await _firestore.collection("users").doc(userUid).collection("userGroups").add({
        'groupImg' : groupImg,
        'name' : groupName,
        'leader' : userUid,
        // 'members' : members,
        'groupCreated' : Timestamp.now(),
        'groupId' : _ref2.id,
      });

      return retVal = "success";

    }catch(e){
      print(e);
    }


    return retVal;
  }

    Future<String> joinGroup(String groupId, String userUid, String groupName, String groupImg) async {
    String retVal = "error";
    List<String> members = List();
    List<String> memberOfGroup = List();

    try{
      members.add(userUid);
      await _firestore.collection("groups").doc(groupId).update({
        'members' : FieldValue.arrayUnion(members),
      });
      members.add(userUid);
       await _firestore.collection("users").doc(userUid).collection("userGroups").add({
        'name' : groupName,
        'leader' : userUid,
        'groupImg' : groupImg,
        // 'members' : members,
        'groupCreated' : Timestamp.now(),
        'groupId' : groupId,
      });
       memberOfGroup.add(groupId);
       await _firestore.collection("users").doc(userUid).update({
        // 'memberOfGroup' : groupId, //chnage from groupId
        'memberOfGroup' : FieldValue.arrayUnion(memberOfGroup),
      });
      return retVal = "success";

    }catch(e){
      print(e);
    }


    return retVal;
  }

  //get group list 
  getGroupData(String userUid) async {
    return await FirebaseFirestore.instance.collection("users").doc(userUid).collection("userGroups").snapshots();
  }
  //get quiz list
  getQuizData(String groupId) async {
    return await FirebaseFirestore.instance.collection("groups").doc(groupId).collection("groupQuiz").snapshots();
  }

  Future<void> addQuizData(Map quizData, String quizId, String groupId) async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("groupQuiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e);
    });
  }
  
  Future<void> addQuestionData(quizData, String quizId, String groupId) async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("groupQuiz")
        .doc(quizId)
        .collection("QNA")
        .add(quizData)
        .catchError((e) {
      print(e);
    });
  }
  
  getQuestionData(String quizId, String groupId) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("groupQuiz")
        // .doc("jsM91053i98ttj68")
        .doc(quizId)
        .collection("QNA")
        .get();
  }




///////
   Future<UserModel> getGroupList(String uid) async {
    UserModel retVal = UserModel();

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(uid).get();
      retVal.groupId = _docSnapshot.data()["groupId"];
      retVal.memberOfGroup = _docSnapshot.data()["memberOfGroup"];
    }catch(e) {
      print(e);
    }

    return retVal;
  }

  //get group stream 
  Stream<List<GroupModel>> get groups {
    CollectionReference groupCollection = FirebaseFirestore.instance.collection("users");
    return groupCollection.snapshots()
    .map(_groupListFromSnapshot);
  }

  
  
  
  //group list from snapshot
  List<GroupModel> _groupListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return GroupModel(
        name: doc.data()['name']?? '',
        id: doc.data()['id']?? '',
        // members: doc.data()['members']?? '0', //for 
        );
    }).toList();
  }

  //dari video lain
  // Future getGroupList2() async {
  //   List itemsList = [];
  //   try{
  //     await groupCollection.get().then((querySnapshot){
  //       querySnapshot.docs.forEach((element){
  //         itemsList.add(element.data);
  //       });
  //     });
  //     return itemsList;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  

  


 

}