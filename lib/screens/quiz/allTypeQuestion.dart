import 'package:flutter/material.dart';

import 'package:random_string/random_string.dart';
import 'package:tekko/screens/quiz/addQuestion.dart';
import 'package:tekko/services/database.dart';

class CreateMCQAndOpenEndedQuestions extends StatefulWidget {

  final String groupIdFromGroupList;

  CreateMCQAndOpenEndedQuestions(this.groupIdFromGroupList);
  
  @override
  _CreateMCQAndOpenEndedQuestionsState createState() =>
      _CreateMCQAndOpenEndedQuestionsState();
}

class _CreateMCQAndOpenEndedQuestionsState
    extends State<CreateMCQAndOpenEndedQuestions> {
  Database databaseService = new Database();
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl, quizTitle, quizDesc;

  bool isLoading = false;
  String quizId;

  createQuiz() {
    quizId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "id" : quizId,
        "quizImgUrl": quizImgUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc
      };

      databaseService.addQuizData(quizData, quizId, widget.groupIdFromGroupList).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestion(quizId, widget.groupIdFromGroupList)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        // title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? "Please enter the quiz image url" : null,
                decoration: InputDecoration(
                    labelText: "Enter image url", hintText: "Quiz Image Url"),
                onChanged: (val) {
                  quizImgUrl = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? "Please enter the quiz title" : null,
                decoration: InputDecoration(
                    labelText: "Enter quiz title", hintText: "Quiz Title"),
                onChanged: (val) {
                  quizTitle = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? "Please enter the quiz description" : null,
                decoration: InputDecoration(
                    labelText: "Enter quiz description",
                    hintText: "Quiz Description"),
                onChanged: (val) {
                  quizDesc = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Create Quiz",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
