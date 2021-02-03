import 'package:flutter/material.dart';
// import 'package:quizapp2/widget/widget.dart';

class CreateYesNoQuestions extends StatefulWidget {
  
  @override
  _CreateYesNoQuestionsState createState() => _CreateYesNoQuestionsState();
}

class _CreateYesNoQuestionsState extends State<CreateYesNoQuestions> {
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
        body: Text("Hello"));
  }
}
