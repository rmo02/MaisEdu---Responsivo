import 'dart:convert';
import 'dart:async';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/interfaces/atv.dart';
import 'package:resposividade/interfaces/disciplina.dart';
import 'package:resposividade/quizz/startQuizz.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Aulas extends StatefulWidget {
  final String id;
  const Aulas({Key? key, required this.id}) : super(key: key);

  @override
  State<Aulas> createState() => _AulasState();
}

class _AulasState extends State<Aulas> {
  List _aulas = [];
  List _conteudo = [];

  //get disciplinas por id
  Future<Disciplina> _GetDisciplinas() async {
    //ID da matéria
    var id = this.widget.id;

    var disciplinas = "http://192.168.6.20:3010/disciplinasAluno/${id}";
    var url = Uri.parse(disciplinas);
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map r = jsonDecode(resposta.body)["disciplinas"];
       print(r);
      return Disciplina.fromJson(jsonDecode(resposta.body)["disciplinas"]);
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }

  //get aulas
  // _pegarAulas() async {
  //   //pegando ID do aluno
  //   SharedPreferences idALuno = await SharedPreferences.getInstance();
  //   String id = idALuno.getString('id')!;
  //   List<dynamic> values = id.split("Id ");
  //
  //   var disciplinas =
  //       "http://192.168.6.20:3010/aulas/series/${id}/${widget.id}";
  //   var url = Uri.parse(disciplinas);
  //   var resposta = await http.get(url);
  //   if (resposta.statusCode == 200) {
  //     Map<String, dynamic> map = jsonDecode(resposta.body);
  //     List<dynamic> data = map["aulas_final"];
  //     print(_aulas);
  //     setState(() {
  //       _aulas = data;
  //     });
  //     return data;
  //   } else {
  //     throw Exception('Nao foi possivel carregar usuários');
  //   }
  // }

  _pegarConteudo() async {
    //pegando ID do aluno
    SharedPreferences idALuno = await SharedPreferences.getInstance();
    String id = idALuno.getString('id')!;


    var conteudo =
        "http://192.168.6.20:3010/conteudosAluno/${id}/${widget.id}";
    var url = Uri.parse(conteudo);
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      List<dynamic> data = map["conteudo"];
      // print(_conteudo);
      setState(() {
        _conteudo = data;
      });
      return data;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }

  late Future<Disciplina> futureDisciplina;

  @override
  void initState() {
    super.initState();
     // _pegarAulas();
    futureDisciplina = _GetDisciplinas();
    _pegarConteudo();
  }


  bool _playArea = false;
  VideoPlayerController? _controller;
  CustomVideoPlayerController? _customVideoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(color: AppStyle.secondColor)
          : BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          if (_playArea == false)
            Container(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<Disciplina>(
                      future: futureDisciplina,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.name,
                            style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Sem aulas');
                        }
                        return CircularProgressIndicator();
                      }),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          else
            Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding:
                        const EdgeInsets.only(top: 50, left: 30, right: 30),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  _playView(context),
                  SizedBox(
                    height: 15,
                  )
                  // _controlView(context),
                ],
              ),
            ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70))),
              child: Column(
                children: [
                  _listViewCard(),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  //inicializar o vídeo
  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return CustomVideoPlayer(
        customVideoPlayerController: _customVideoPlayerController!,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  //controller do VídeoPlayer
  _onTapVideo(int index) {
    final controller = VideoPlayerController.network(_aulas[index]["file"]);
    _controller = controller;
    setState(() {});
    controller..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        additionalVideoSources: {
          "auto": controller,
          "360p": controller,
          "720p": controller,
          "1080p": controller
        },
        customVideoPlayerSettings: const CustomVideoPlayerSettings(
          customAspectRatio: 16 / 9,
          showPlayButton: true,
        ),
        videoPlayerController: controller);
  }

  //Listando todas as disciplinas
  _listViewCard() {
    return Expanded(
      child: ListView.builder(
          itemCount: _aulas.length,
          itemBuilder: (context, int index) {
            //Definindo a area do player de vídeo.
            return GestureDetector(
              onTap: () {
                _onTapVideo(index);
                debugPrint(index.toString());
                setState(() {
                  if (_playArea == false) {
                    _playArea = true;
                  }
                });
              },
              child: _buildCard(index),
            );
          }),
    );
  }

  //Colocando Thumb e Título nos vídeos
  _buildCard(int index) {
    return Container(
      width: 200,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(_aulas[index]['thumb']),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                padding: EdgeInsets.only(left: 15),
                child: AutoSizeText(
                  _aulas[index]["title"],
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          //tracejado
          Row(
            children: [
              for (int i = 0; i < 110; i++)
                i.isEven
                    ? Container(
                        width: 3,
                        height: 1,
                        decoration: BoxDecoration(
                            color: Color(0xFF839fed),
                            borderRadius: BorderRadius.circular(2)),
                      )
                    : Container(
                        width: 3,
                        height: 1,
                        color: Colors.white,
                      )
            ],
          ),
        ],
      ),
    );
  }
}
