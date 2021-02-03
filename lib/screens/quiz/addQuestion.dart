import 'package:flutter/material.dart';
import 'package:tekko/services/database.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  final String groupIdFromGroupList;
  AddQuestion(this.quizId, this.groupIdFromGroupList);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  Database databaseService = new Database();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool _isMCQ = false;

  String _selectedQuestion = null;

  String question = "",
      option1 = "",
      option2 = "",
      option3 = "",
      option4 = "",
      correctAnswer = "";

  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      if (_isMCQ) {
        Map<String, String> questionMap = {
          "question": question,
          "option1": option1,
          "option2": option2,
          "option3": option3,
          "option4": option4
        };
        print("${widget.quizId}");
        databaseService
            .addQuestionData(questionMap, widget.quizId, widget.groupIdFromGroupList)
            .then((value) {
          question = "";
          option1 = "";
          option2 = "";
          option3 = "";
          option4 = "";
          setState(() {
            isLoading = false;
          });
        }).catchError((e) {
          print(e);
        });
      } else {
        Map<String, String> questionMap = {
          "question": question,
          "correctAnswer": correctAnswer
        };

        print("${widget.quizId}");
        databaseService
            .addQuestionData(questionMap, widget.quizId, widget.groupIdFromGroupList)
            .then((value) {
          question = "";
          correctAnswer = "";
          setState(() {
            isLoading = false;
          });
        }).catchError((e) {
          print(e);
        });
      }


    } else {
      print("error is happening ");
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
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Please enter your question" : null,
                      decoration: InputDecoration(
                          labelText: "Enter your question",
                          hintText: "Question"),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
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
                            setState(() {
                              _selectedQuestion = value;
                            });
                            _selectedQuestion = value;
                            switch (value) {
                              case "Multiple Choice Questions":
                                _isMCQ = true;
                                break;
                              case "Open Ended Questions":
                                _isMCQ = false;
                                break;
                            }
                          },
                          hint: Text('Select type of questions'),
                        ),
                      ),
                    ),
                    //to check whether MCQ or open ended is picked

                    _isMCQ
                        ? Column(children: [
                            TextFormField(
                              onChanged: (val) {
                                option1 = val;
                              },
                              validator: (val) =>
                                  val.isEmpty ? "Option1 " : null,
                              decoration: InputDecoration(
                                  hintText: "Option1 (Correct Answer)"),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Option2 " : null,
                              decoration: InputDecoration(hintText: "Option2"),
                              onChanged: (val) {
                                option2 = val;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Option3 " : null,
                              decoration: InputDecoration(hintText: "Option3"),
                              onChanged: (val) {
                                option3 = val;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Option4 " : null,
                              decoration: InputDecoration(hintText: "Option4"),
                              onChanged: (val) {
                                option4 = val;
                              },
                            )
                          ])
                        : Column(children: [
                            TextFormField(
                              onChanged: (val) {
                                option1 = val;
                              },
                              validator: (val) =>
                                  val.isEmpty ? "correctAnswer " : null,
                              decoration:
                                  InputDecoration(hintText: "correctAnswer"),
                            )
                          ]),
                    SizedBox(
                      height: 8,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Submit",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            uploadQuizData();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Add Question",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = ["Multiple Choice Questions", "Open Ended Questions"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }
}
