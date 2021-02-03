import 'package:flutter/material.dart';
import 'package:tekko/screens/quiz/allTypeQuestion.dart';
import 'package:tekko/screens/quiz/yesNoGame.dart';


class ChooseQuiz extends StatefulWidget {

   final String groupIdFromGroupList;
   ChooseQuiz(this.groupIdFromGroupList);

  @override
  _ChooseQuizState createState() => _ChooseQuizState();
}

class _ChooseQuizState extends State<ChooseQuiz> {
  String _selectedQuestion = null;

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
      body: Center(
        heightFactor: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black12,
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedQuestion,
                items: _dropDownItem(),
                onChanged: (value) {
                  _selectedQuestion = value;
                  switch (value) {
                    case "Multiple Choice/Open Ended Questions":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateMCQAndOpenEndedQuestions(widget.groupIdFromGroupList)),
                      );
                      break;
                    case "Yes/No Questions":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateYesNoQuestions()),
                      );
                      break;
                  }
                },
                hint: Text('Select type of questions'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = [
      "Multiple Choice/Open Ended Questions",
      "Yes/No Questions"
    ];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }
}
