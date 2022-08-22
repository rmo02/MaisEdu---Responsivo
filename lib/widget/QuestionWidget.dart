import 'dart:async';
// import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resposividade/interfaces/atv.dart';
// import 'package:http/http.dart' as http;

class QuizScreeen extends StatefulWidget {
  String id;

  QuizScreeen({required this.id});

  @override
  State<QuizScreeen> createState() => _QuizScreeenState();


}

class _QuizScreeenState extends State<QuizScreeen> {



  var currentQuestionIndex = 0;
  int seconds = 60;
  Timer? timer;
  late Future quiz;

  int points = 0;

  var isLoaded = false;

  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.blueAccent],
            )),
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){

              var data = snapshot.data["questoes"];

              if(isLoaded ==  false){
                optionsList = data[currentQuestionIndex]["incorrect_answers"];
                optionsList.add(data[currentQuestionIndex]["correct_answer"]);
                optionsList.shuffle();
                isLoaded = true;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: Colors.white,
                                size: 28,
                              )),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text('$seconds', style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 22
                            ),),
                            SizedBox(
                              height: 60,
                              width:60,
                              child: CircularProgressIndicator(
                                value: seconds / 60,
                                valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
                              ),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white, width: 2)
                          ),
                          child: TextButton.icon(onPressed: null, icon: Icon(
                            CupertinoIcons.heart_fill, color: Colors.white, size: 18,),
                              label: Text('Like', style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 14
                              ),)),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Image.asset('assets/images/banner2.png'),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Questão ${currentQuestionIndex + 1}/ ${data.length}',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.white
                      ),),
                    ),
                    const SizedBox(height: 20,),
                    Text(data[currentQuestionIndex]["question"], style: GoogleFonts.roboto(
                        fontSize: 22,
                        color: Colors.white
                    ),),
                    const SizedBox(height: 20,),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionsList.length,
                        itemBuilder:(BuildContext context, int index){

                          var answer = data[currentQuestionIndex]["correct_answer"];


                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (answer.toString() == optionsList[index].toString()) {
                                  optionsColor[index] = Colors.green;

                                  points = points + 10;
                                } else {
                                  optionsColor[index] = Colors.red;
                                }

                                if (currentQuestionIndex < data.length - 1) {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    isLoaded = false;
                                    currentQuestionIndex++;
                                    resetColors();
                                    timer!.cancel();
                                    seconds = 60;
                                    startTimer();
                                  });
                                } else {
                                  timer!.cancel();
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: size.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: optionsColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(optionsList[index].toString(), style: GoogleFonts.roboto(
                                color: Colors.blue, fontSize: 18,
                              ),),
                            ),
                          );
                        } )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),);
            }
          },
        ),
      ),
    );
  }


}
