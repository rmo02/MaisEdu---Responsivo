import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:resposividade/widget/QuestionWidgetTeste.dart';

class startQuizz extends StatelessWidget {
  const startQuizz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.blueAccent],
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
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
            SizedBox(height: 30,),
            Image.asset(
              'assets/images/balloon2.png',
            ),
            const SizedBox(height: 20),
            Center(
               child: Text("Bem vindo ao quiz", style: GoogleFonts.roboto(
                 color: Colors.white,
                 fontSize: 22
               ),),
             ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Text("Resolva as questoes para subir de rank e aumentar seu nivel de aprendizado",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16
              ),),
            ),
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreeen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  width: size.width - 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text("Continue", style: GoogleFonts.roboto(
                    color: Colors.blue, fontSize: 18,
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
