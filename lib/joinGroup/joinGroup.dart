import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tekko/screens/root/root.dart';
import 'package:tekko/services/database.dart';
import 'package:tekko/states/currentUser.dart';
import 'package:tekko/widgets/container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinGroup extends StatefulWidget {
  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {

    void _joinGroup(BuildContext context, String groupId) async {
     CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

      String groupName, groupImg;
      await FirebaseFirestore.instance.collection("groups").doc(groupId).get().then((addGroupId) => groupName = addGroupId.data()['name'] );  
      await FirebaseFirestore.instance.collection("groups").doc(groupId).get().then((addGroupId) => groupImg = addGroupId.data()['groupImg'] );  
      

     String _returnString = await Database().joinGroup(groupId, _currentUser.getCurrentUser.uid, groupName, groupImg);
     
     if( _returnString == "success"){
       Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(
          builder: (context)=> LoginRoot(),
          ),
          (route) => false);
     }
    }

  TextEditingController _groupIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ShadowContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Id",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Join",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () => _joinGroup(context, _groupIdController.text),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}