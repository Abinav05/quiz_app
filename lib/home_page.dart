import 'package:flutter/material.dart';
import 'package:quiz_app/color_contans.dart';
import 'package:quiz_app/dummy_db.dart';
import 'package:quiz_app/result_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestion = 1;
  int lastQst = 10;
  dynamic questionIndex = 0;
  int? _selectedOption;
  int _score = 0; // Variable to keep track of the score

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryblack,
      appBar: AppBar(
        title: Text(
          "QUIZ APP",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorConstants.primaryblack,
        actions: [
          Text(
            "$_currentQuestion/$lastQst",
            style: TextStyle(color: ColorConstants.primarywhite),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    DummyDb.questionList[questionIndex]["qustions"],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: ColorConstants.primarywhite),
                  ),
                ),
                decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Column(
                children: List.generate(
              4,
              (optionIndex) => Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    if (_selectedOption == null) {
                      setState(() {
                        _selectedOption = optionIndex;
                        if (optionIndex ==
                            DummyDb.questionList[questionIndex]
                                ["answerIndex"]) {
                          _score++; // Increment score if the selected option is correct
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: getColor(optionIndex),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DummyDb.questionList[questionIndex]["options"]
                              [optionIndex],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: ColorConstants.primarywhite),
                        ),
                        Icon(
                          Icons.circle_outlined,
                          color: _selectedOption == optionIndex
                              ? DummyDb.questionList[questionIndex]
                                          ["answerIndex"] ==
                                      optionIndex
                                  ? ColorConstants.primarygreen
                                  : ColorConstants.primaryred
                              : ColorConstants.primarygrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (questionIndex < lastQst - 1) {
                  setState(() {
                    _selectedOption = null;
                    questionIndex++;
                    _currentQuestion = questionIndex + 1;
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        score: _score,
                        totalQuestions: lastQst,
                        onRestart: () {
                          // Logic to restart the quiz
                          setState(() {
                            _score = 0;
                            questionIndex = 0;
                            _currentQuestion = 1;
                            _selectedOption = null;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  );
                }
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.primaryred,
                ),
                child: Center(
                  child: Text(
                    questionIndex < lastQst - 1 ? "Next" : "Finish",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: ColorConstants.primarywhite,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(int currentOptionIndex) {
    if (_selectedOption != null &&
        currentOptionIndex ==
            DummyDb.questionList[questionIndex]["answerIndex"]) {
      return ColorConstants.primarygreen;
    }

    if (_selectedOption == currentOptionIndex) {
      if (_selectedOption ==
          DummyDb.questionList[questionIndex]["answerIndex"]) {
        return ColorConstants.primarygreen;
      } else {
        return ColorConstants.primaryred;
      }
    } else {
      return ColorConstants.primarygrey;
    }
  }
}
