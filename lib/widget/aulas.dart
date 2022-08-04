import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/interfaces/atv.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:video_player/video_player.dart';

class Aulas extends StatefulWidget {
  const Aulas({Key? key}) : super(key: key);

  @override
  State<Aulas> createState() => _AulasState();
}

class _AulasState extends State<Aulas> {
  List _aulas = [];

  _pegarAulas() async {
    var url = Uri.parse(
        'http://192.168.6.20:3010/aulas/series/2c4c4950-8bad-41ed-970d-d32546baea2c/31d9ef2d-0dc8-4108-8549-ddd6d117e7c5');
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      List<dynamic> data = map["aulas"];
        setState(() {
          _aulas = data;
        });
      print(_aulas);
      return data;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }

  @override
  void initState(){
    super.initState();
    _pegarAulas();
  }



  List<Atv> atvs = [
    Atv(1, "Aula 1", "Aula 1 sobre matemática básica", false),
    Atv(2, "Aula 2", "Aula 2 sobre a trigonometria", false),
  ];

  bool _playArea = false;
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
              //height: MediaQuery.of(context).size.height/2,
          decoration: _playArea==false?BoxDecoration(
            color: AppStyle.secondColor
          ): BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppStyle.grientCard,
                    AppStyle.gradientCart2
                ]
              )
          ),
          child: Column(
            children: [
              _playArea==false?Container(
                padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap:() {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios, size: 20,
                            color: Colors.white,

                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(Icons.info_outline, size: 20,
                          color: Colors.white,)
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Matemática",
                      style: GoogleFonts.roboto(
                          fontSize: 25,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              ): Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                      child:  Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_ios,
                            size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,size: 20, color: Colors.white,)
                        ],
                      ),
                    ),
                    _playView(context),
                    _controlView(context),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70)
                      )
                    ),
                    child: Column(
                      children: [
                        _listViewCard(),
                      ],
                    ),
                ),
              )

            ],
          ),
      )
    );
  }

  Widget _controlView(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,

      child: (
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff364fc7)
                ),
                onPressed: () {

                },
                child: Icon(Icons.fast_rewind,
                  size: 36,
                  color: Colors.white,)
            ),
            SizedBox(width: 5,),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff364fc7)
                ),
                onPressed: () async {
                  if(_isPlaying){
                    setState(() {
                      _isPlaying=false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying=true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon( _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                  color: Colors.white,)
            ),
            SizedBox(width: 5,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff364fc7)
                ),
                onPressed: (){

                },
                child: Icon(Icons.fast_forward,
                  size: 36,
                  color: Colors.white,)
            )
          ],
        )
      ),
    );
  }

  Widget _playView(BuildContext context){
    final controller = _controller;
    if(controller!=null && controller.value.isInitialized){
      return AspectRatio(
        aspectRatio: 16/9,
        child: VideoPlayer(controller),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  void _onControllerUpdate () async {
    final controller = _controller;
    if(controller == null){
      return ;
    }
    if(!controller.value.isInitialized){
      return ;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }
  _onTapVideo(int index){
    final controller = VideoPlayerController.network(_aulas[index]["file"]);
    _controller = controller;
    setState(() {

    });
    controller..initialize().then((_){
      controller.addListener(_onControllerUpdate);
      controller.play();
      setState(() {

      });
    });
  }
  _listViewCard(){
    return Expanded(
            child: ListView.builder(
                itemCount: _aulas.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: (){
                      _onTapVideo(index);
                      debugPrint(index.toString());
                      setState(() {
                        if(_playArea == false){
                          _playArea=true;
                        }
                      });
                    },
                    child: _buildCard(index),
                  );
                }),
          );
        }

  _buildCard(int index) {
    return Container(
      width: 200,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20),
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
                child: Image.network(
                    _aulas[index]['thumb']
                ),
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
          Row(
            children: [
              for(int i=0; i<110; i++)
                i.isEven?Container(
                  width: 3,
                  height: 1,
                  decoration: BoxDecoration(
                      color: Color(0xFF839fed),
                      borderRadius: BorderRadius.circular(2)
                  ),
                ): Container(
                  width: 3,
                  height: 1,
                  color: Colors.white,
                )
            ],
          )
        ],
      ),
    );
  }
}