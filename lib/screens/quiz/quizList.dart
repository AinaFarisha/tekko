import 'package:flutter/material.dart';
import 'package:tekko/screens/quiz/choose.dart';
// import 'package:tekko/createOrJoinGroup/createJoinOption.dart';
import 'package:tekko/screens/quiz/chooseQuiz.dart';
// import 'package:tekko/screens/quiz/createQuiz.dart';
import 'package:tekko/screens/quiz/quizPlay.dart';
import 'package:tekko/services/database.dart';
// import 'package:tekko/states/currentUser.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class QuizList extends StatefulWidget {
    final String groupIdFromGroupList;
    QuizList(this.groupIdFromGroupList);
    

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  
     
  Stream quizStream;
  Database databaseService = new Database();
  

  Widget quizList(String groupIdFromGroupList) {
          return Container(
            child: StreamBuilder(
              stream: quizStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.data == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return QuizTile(
                            noOfQuestions: snapshot.data.docs.length,
                          imageUrl:
                              snapshot.data.docs[index].data()['quizImgUrl'],
                          title:
                              snapshot.data.docs[index].data()['quizTitle'],
                          description:
                              snapshot.data.docs[index].data()['quizDesc'],
                          id: snapshot.data.docs[index].data()['id'], 
                          groupID: groupIdFromGroupList,
                          );
                        });
              },
            ),
          );
  }

  @override
  void initState() {
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    // String userId =_currentUser.getCurrentUser.uid;

      // String groupId;
      // CollectionReference groupId = await FirebaseFirestore.instance.collection("groups");  
      // print(groupId);
      // String groupId = groupId as String;

      // String groupId;
      // CollectionReference userGroupsId = await FirebaseFirestore.instance.collection("userss").doc(userId).collection("userGroups");  
      // String userGroups = userGroupsId as String;

      // String groupIdFromuserGroupsCollection;
      // await FirebaseFirestore.instance.collection("users").doc(userId).collection("userGroups").doc(userGroups).get().then((addGroupId) => groupIdFromuserGroupsCollection = addGroupId.data()['name'],);
    
    
    databaseService.getQuizData(widget.groupIdFromGroupList).then((value) {
      quizStream = value;
      setState(() {});
    });
    super.initState();
  }
 
  // void _showAddGroupPanel() {
  //     showModalBottomSheet(context: context, builder: (context) {
  //       return Container(
  //         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
  //         child: AddGroup(),
  //       );
  //     });
  //   }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: quizList(widget.groupIdFromGroupList),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // CreateQuiz(widget.groupIdFromGroupList)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChooseQuiz(widget.groupIdFromGroupList)));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, id, description, groupID;
  final int noOfQuestions;

  // String groupID;

  // CurrentUser _currentUser = new CurrentUser();
  

  QuizTile(
      {
        @required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.id,
      @required this.noOfQuestions, @required this.groupID,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => QuizPlay(id, groupID),
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
                        title,
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
