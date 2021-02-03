import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tekko/createGroup/createGroup.dart';
import 'package:tekko/joinGroup/joinGroup.dart';
import 'package:tekko/screens/root/root.dart';
import 'package:tekko/services/database.dart';
import 'package:tekko/states/currentUser.dart';
import 'package:tekko/widgets/container.dart';

class AddGroup extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              // child: ShadowContainer(
                child: Column(
                  children: <Widget>[
                    Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
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


                  ],
                
              ),
            // ),
            ),
          ],
    ),
      ));
  }
}