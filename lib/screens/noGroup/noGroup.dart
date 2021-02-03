import 'package:flutter/material.dart';
import 'package:tekko/createGroup/createGroup.dart';
import 'package:tekko/joinGroup/joinGroup.dart';
import 'package:tekko/screens/home/home.dart';
import 'package:tekko/screens/root/root.dart';
import 'package:tekko/states/currentUser.dart';
import 'package:provider/provider.dart';

class NoGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    void _toJoin(BuildContext context){
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context)=> JoinGroup(),
          ),
          );
    }
    void _toCreate(BuildContext context){
       Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context)=> CreateGroup(),
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
    return Scaffold(
       appBar: AppBar(
          title: Text("HOME PAGE"),
           backgroundColor: Colors.blueAccent,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.exit_to_app),
                label: Text('Log Out'),
                onPressed: () => _signOut(context),
              )
            ],
        ),
      body: Column(
        children: <Widget>[
          Spacer(
            flex: 1,
            ),
            Padding(
              padding: EdgeInsets.all(80.0),
              child: Image.asset("assets/logo.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text("Welcome!",
              textAlign: TextAlign.center,
              style: TextStyle(
                 fontSize: 40.0,
                 color: Colors.grey[600],
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Start your journey with \"tekko\" now",
              textAlign: TextAlign.center,
              style: TextStyle(
                 fontSize: 20.0,
                 color: Colors.grey[600],
              ),),
              ),
            Spacer(
            flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                RaisedButton(
                  child: Text("Create",
                  style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: ()=> _toCreate(context),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 2,
                    ),
                    ),
                  ),
                RaisedButton(
                  child: Text("Join",
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()=> _toJoin(context),
                  
                  ),
              ],
              ),
            )
        ]
      ),
    );
  }
}