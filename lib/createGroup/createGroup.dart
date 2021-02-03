import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tekko/screens/root/root.dart';
import 'package:tekko/services/database.dart';
import 'package:tekko/states/currentUser.dart';
import 'package:tekko/widgets/container.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  // void _goToAddBook(BuildContext context, String groupName) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => OurAddBook(
  //         onGroupCreation: true,
  //         onError: false,
  //         groupName: groupName,
  //       ),
  //     ),
  //   );
  // }
   void _createGroup(BuildContext context, String groupName, String groupImage) async {
     CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
     String _returnString = await Database().createGroup(groupName, _currentUser.getCurrentUser.uid, groupImage);
     
     if( _returnString == "success"){
       Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(
          builder: (context)=> LoginRoot(),
          ),
          (route) => false);
     }
    }

  TextEditingController _groupNameController = TextEditingController();
  TextEditingController _groupImageController = TextEditingController();
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
                    controller: _groupImageController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.image),
                      hintText: "Group Image",
                    ),
                  ),
                  TextFormField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () => _createGroup(context, _groupNameController.text, _groupImageController.text),
                    // =>
                        // _goToAddBook(context, _groupNameController.text),
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