
import 'package:flutter/material.dart';
import 'package:tekko/models/group.dart';
import 'package:tekko/screens/groupList/groupList.dart';
import 'package:tekko/screens/noGroup/noGroup.dart';
import 'package:tekko/screens/root/root.dart';
import 'package:tekko/services/database.dart';
import 'package:tekko/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  void _goToNoGroup(BuildContext context){
    Navigator.push(context, 
    MaterialPageRoute(
          builder: (context)=> NoGroup(),
             ),
          );
        }

  void _signOut(BuildContext context) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
      String _returnString = await _currentUser.signOut(); 
        if (_returnString == "success"){
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(
              builder: (context)=> LoginRoot(),
                ),
             (route) => false,
         );
   }
  }


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<GroupModel>>.value(
      value: Database().groups,
      initialData: List(),
          child: Scaffold(
        appBar: AppBar(
          title: Text("HOME PAGE"),
           backgroundColor: Colors.purpleAccent,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.exit_to_app),
                label: Text('Log Out'),
                onPressed: () => _signOut(context),
              )
            ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 RaisedButton(
                  child: Text("Create and Join",
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()=> _goToNoGroup(context),
                ),
                // GroupList(),
                RaisedButton(
                  child: Text("List",
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()=> Navigator.push(context, 
    MaterialPageRoute(
          builder: (context)=> GroupList(),
             ),
          )
                ),
               
              ],
            ),
          )
        ),
      
      ),
    ); 
  }
}


// StreamBuilder(
//                   stream: FirebaseFirestore.instance.collection("groups").snapshots(),
//                   // ignore: missing_return
//                   builder: (context, snapshot){
//                     if (snapshot.hasData) {
//                       return ListView.builder(
//                         itemCount: snapshot.data.docs.length,
//                         itemBuilder: (context, index) {
//                           DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
//                           return Row(children: <Widget>[
//                            Expanded(
//                              child: Text(documentSnapshot.data()["name"])
//                            )
//                           ],);
//                         }
//                       );
//                     }
//                   }
//                 ),