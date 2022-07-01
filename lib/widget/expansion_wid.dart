import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:resposividade/widget/QuestionWidget.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:video_player/video_player.dart';
import '../interfaces/atv.dart';

class ExpansionWid extends StatefulWidget {
  const ExpansionWid({Key? key}) : super(key: key);
  @override
  State<ExpansionWid> createState() => _ExpansionWidState();
}

class _ExpansionWidState extends State<ExpansionWid> {

  VideoPlayerController? controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState(){
    controller = VideoPlayerController.network("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4");
    _initializeVideoPlayerFuture = controller!.initialize();
    controller!.setLooping(true);
    controller!.setVolume(1.0);
    super.initState();
    controller!.play();
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  List<Atv> atvs = [
    Atv(1, "Aula 1", "Aula 1 sobre a legalidade", false),
    Atv(2, "Aula 2", "Aula 1 sobre a legalidade", false),
  ];

  @override
  Widget build(BuildContext context) {
    final isMuted = controller!.value.volume == 0;
    return ExpansionPanelList.radio(
      elevation: 0,

      children: atvs.map((atv){
        return ExpansionPanelRadio(
            backgroundColor: AppStyle.mainColor,
            canTapOnHeader: true,
            value: atv.id,
            headerBuilder: (bc, status) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      child: Image.asset('assets/images/play-button.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Text(atv.name)
                  ],
                ),
              );
            }, body: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .37,
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(aspectRatio: controller!.value.aspectRatio,
                      child: VideoPlayer(controller!),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: (){},
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 2),
                            Text("Comentários")
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            primary: AppStyle.secondColor
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 5),
                            Text("Anotações")
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            primary: AppStyle.secondColor
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 5),
                            Text("Favoritos")
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            primary: AppStyle.secondColor
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                      child: Text(controller!.value.isPlaying ? 'Pause' : 'Play'),
                      onPressed: (){
                        if(controller!.value.isPlaying){
                          controller!.pause();
                        }else{
                          controller!.play();
                        }
                      }
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(context, PageTransition(
                        child: QuestionWidget(),
                        type:  PageTransitionType.fade,
                        duration: const Duration(milliseconds: 10)
                    )
                    );
                  }, child: Text("Atividade 1"))
                ],
              );
            }  else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        );
      }).toList(),
    );

  }
}