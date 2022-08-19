import 'dart:convert';
import 'dart:async';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:resposividade/interfaces/atv.dart';
import 'package:resposividade/interfaces/disciplina.dart';
import 'package:resposividade/pages/bottomNavPages/perfil_page.dart';
import 'package:resposividade/quizz/startQuizz.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:resposividade/widget/conteudo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Aulas extends StatefulWidget {
  final String id;
  const Aulas({Key? key, required this.id}) : super(key: key);

  @override
  State<Aulas> createState() => _AulasState();
}

class _AulasState extends State<Aulas> {
  List _conteudo = [];




  _pegarConteudo() async {
    var idDisciplina = this.widget.id;
     print(idDisciplina);

    //pegando ID do aluno
    SharedPreferences idALuno = await SharedPreferences.getInstance();
    String id = idALuno.getString('id')!;
     print(id);

    var conteudo =
        "http://192.168.6.20:3010/conteudosAluno/${id}/${widget.id}";
    var url = Uri.parse(conteudo);
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      List<dynamic> data = map["conteudo"]['conteudo'];

      setState(() {
        _conteudo = data;
      });
      return data;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }


  @override
  void initState() {
    super.initState();
    _pegarConteudo();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 120,
          height: 60,
          child: Image.asset(
            'assets/images/logo-educacao.png',
          ),
        ),
        backgroundColor: AppStyle.secondColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_outlined,
              size: 25,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(
                context,
                PageTransition(
                    child: PerfilPage(),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 10))),
            icon: Icon(
              Icons.person,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: AppStyle.mainColor,
      body: Container(
        child: ListView.builder(
          itemCount: _conteudo.length,
            itemBuilder: (context, index){
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      // print(_conteudo[index]['id']);
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => ConteudoPage(id: _conteudo[index]['id'])
                          ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(top: 15, left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      child: Text(_conteudo[index]['name'], style: GoogleFonts.roboto(
                        color: AppStyle.titleColor,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                    ),
                  ),
                ],
              ),
            );
            }),
      ),
    );
  }

}
