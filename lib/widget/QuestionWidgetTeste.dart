import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/pages/quali_page.dart';
import 'package:resposividade/quizz/startQuizz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreeen extends StatefulWidget {
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
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top:0, left: 12, right: 12, bottom: 12),
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
                optionsList = data[currentQuestionIndex]["opcoes"];
                isLoaded = true;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50,),
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
                                showDialog(
                                    context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Deseja sair da atividade?"),
                                    content: Text("Ao sair da atividade seu progresso será reiniciado"),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pushReplacement(
                                            context, MaterialPageRoute(
                                          builder: (context) => startQuizz(),
                                        )
                                        );
                                      }, child: Text('Sair')),
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text('Cancelar')),
                                    ],
                                  )
                                    );
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
                    Image.asset(
                        height: 200,
                        'assets/images/ideas.png'),
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
                    Text(data[currentQuestionIndex]["title"], style: GoogleFonts.roboto(
                        fontSize: 22,
                        color: Colors.white
                    ),),
                    const SizedBox(height: 20,),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionsList.length,
                        itemBuilder:(BuildContext context, int index){

                          //index da resposta correta
                          var answer = data[currentQuestionIndex]["answer_index"];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (optionsList[index] == optionsList[answer]) {
                                  optionsColor[answer] = Colors.green;
                                  points = points + 10;
                                } else {
                                  optionsColor[index] = Colors.red;
                                  points = points - 2;
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
                                }



                                else {
                                  timer!.cancel();
                                  print(points);
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
                                color: Colors.black, fontSize: 18,
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

  getQuiz() async {
    SharedPreferences idAtividade = await SharedPreferences.getInstance();
    String id = idAtividade.getString('id')!;
    List<dynamic> values = id.split("Id ");
    var link = 'http://192.168.6.20:3010/atividadeQuestoes/${id}';
    var res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      print(data);
      return data;
    }
  }


}
