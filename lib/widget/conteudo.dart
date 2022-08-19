import 'dart:convert';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resposividade/interfaces/disciplina.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/style/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConteudoPage extends StatefulWidget {
  final String id;
  const ConteudoPage({Key? key, required this.id}) : super(key: key);


  @override
  State<ConteudoPage> createState() => _ConteudoPageState();
}

class _ConteudoPageState extends State<ConteudoPage> {

  List  _conteudo = [];


  // //get disciplinas por id
  // Future<Disciplina> _GetDisciplinas() async {
  //   //ID da matéria
  //   var id = this.widget.id;
  //
  //   var disciplinas = "http://192.168.6.20:3010/disciplinasAluno/${id}";
  //   var url = Uri.parse(disciplinas);
  //   var resposta = await http.get(url);
  //   if (resposta.statusCode == 200) {
  //     Map r = jsonDecode(resposta.body)["disciplinas"];
  //     // print(r);
  //     return Disciplina.fromJson(jsonDecode(resposta.body)["disciplinas"]);
  //   } else {
  //     throw Exception('Nao foi possivel carregar usuários');
  //   }
  // }
  //
  // late Future<Disciplina> futureDisciplina;

  _pegarConteudo() async {
    var idDisciplina = this.widget.id;
    // print(idDisciplina);

    //pegando ID do aluno
    SharedPreferences idALuno = await SharedPreferences.getInstance();
    String id = idALuno.getString('id')!;
    // print(id);
    var conteudo =
        "http://192.168.6.20:3010/conteudos/${widget.id}";
    var url = Uri.parse(conteudo);
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
        List <dynamic> data = map["conteudo"]['Aula'];
          setState(() {
            _conteudo = data;
          });
      // print(map['conteudo']['Aula'][0]['file']);

      return map;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }

  bool _playArea = false;
  VideoPlayerController? _controller;
  CustomVideoPlayerController? _customVideoPlayerController;


  @override
  void initState(){
    super.initState();
    // futureDisciplina = _GetDisciplinas();
    _pegarConteudo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: Text(_conteudo[0]["file"]),
          ),
        ),
    );
  }


  //inicializar o vídeo
  Widget _playView(BuildContext context) {
    final controler = _controller;
    if (controler != null && controler.value.isInitialized){
      return CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController!,);
    } else {
      return CircularProgressIndicator();
    }
  }

  //controller do VídeoPlayer
  _onTapVideo(int index) {
    final controller = VideoPlayerController.network(_conteudo[index]["file"]);
     print(_conteudo[index]["file"]);
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
          itemCount: _conteudo.length,
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
                child: Image.network(_conteudo[index]['Aula'][index]['thumb']),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                padding: EdgeInsets.only(left: 15),
                child: AutoSizeText(
                  _conteudo[index]['Aula'][index]['title'],
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
              for (int i = 0; i < 105; i++)
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
