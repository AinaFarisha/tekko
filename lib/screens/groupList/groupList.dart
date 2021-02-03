import 'package:flutter/material.dart';
import 'package:tekko/createOrJoinGroup/createJoinOption.dart';
import 'package:tekko/screens/quiz/quizList.dart';
import 'package:tekko/screens/root/root.dart';
import 'package:tekko/services/database.dart';
import 'package:tekko/states/currentUser.dart';
import 'package:provider/provider.dart';

class GroupList extends StatefulWidget {
  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  
  
     
  Stream groupStream;
  Database databaseService = new Database();

  Widget groupList() {
          return Container(
            child: StreamBuilder(
              stream: groupStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.data == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return GroupTile(
                            // noOfQuestions: snapshot.data.documents.length,
                            imageUrl:
                                snapshot.data.docs[index].data()['groupImg'],
                            name:
                                snapshot.data.docs[index].data()['name'],
                            // description:
                            //     snapshot.data.documents[index].data['groupDesc'],
                            id: snapshot.data.docs[index].data()['groupId'],
                          );
                        });
              },
            ),
          );
  }

  @override
  void initState() {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String id =_currentUser.getCurrentUser.uid;
    databaseService.getGroupData(id).then((value) {
      groupStream = value;
      setState(() {});
    });
    super.initState();
  }
 
  void _showAddGroupPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AddGroup(),
        );
      });
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
    return Scaffold(
      // backgroundColor: Colors.white,
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
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddGroupPanel(),
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  final String  name, id, imageUrl;
  // final int noOfQuestions;

  GroupTile(
      {
        @required this.name,
      @required this.imageUrl,
      // @required this.description,
      @required this.id,
      // @required this.noOfQuestions
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => QuizList(id)
        ));
      },
       child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.all(10),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        id,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
