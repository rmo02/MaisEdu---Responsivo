import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:resposividade/quizz/startQuizz.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:video_player/video_player.dart';
import '../interfaces/atv.dart';

class ExpansionWid extends StatefulWidget {
  const ExpansionWid({Key? key}) : super(key: key);
  @override
  State<ExpansionWid> createState() => _ExpansionWidState();
}

class _ExpansionWidState extends State<ExpansionWid> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  String videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
        videoUrl)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  List<Atv> atvs = [
    Atv(1, "Aula 1", "Aula 1 sobre a legalidade", false),
    Atv(2, "Aula 2", "Aula 1 sobre a legalidade", false),
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      elevation: 0,
      children: atvs.map((atv) {
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
                    child: Image.asset(
                      'assets/images/play-button.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(atv.name)
                ],
              ),
            );
          },
          body: Container(
            width: MediaQuery.of(context).size.width * 0.98,
            decoration: BoxDecoration(
                color: Color(0xffF6FAFF),
                borderRadius: BorderRadius.circular(28)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .37,
                    width: MediaQuery.of(context).size.width,
                   child: CustomVideoPlayer(
                     customVideoPlayerController: _customVideoPlayerController,
                   ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(28)),
                                ),
                                backgroundColor: AppStyle.mainColor,
                                context: context,
                                builder: (BuildContext) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(28),
                                            topLeft: Radius.circular(28))),
                                    child: FractionallySizedBox(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.chat,
                                                color: Color(0xff4263EB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Comentários",
                                                style: TextStyle(
                                                  color: Color(0xff868E96),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 20,
                                                right: 20),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3,
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: AppStyle.mainColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  'Enviar comentário',
                                                  style: GoogleFonts.roboto(
                                                    color: Color(0xff4263EB),
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47),
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppStyle.mainColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                              ),
                                              onPressed: () {},
                                              label: Text(
                                                'Meus Comentários',
                                                style: GoogleFonts.roboto(
                                                  color: Color(0xff4263EB),
                                                ),
                                              ),
                                              icon: Icon(
                                                Icons.bookmark,
                                                color: Color(0xff364FC7),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 20,
                                                right: 20,
                                                top: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3,
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.chat,
                                color: Color(0xff4263EB),
                              ),
                              SizedBox(width: 1),
                              Text(
                                "Comentários",
                                style: TextStyle(
                                  color: Color(0xff4263EB),
                                ),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            primary: AppStyle.mainColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(28)),
                                ),
                                backgroundColor: AppStyle.mainColor,
                                context: context,
                                builder: (BuildContext) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(28),
                                            topLeft: Radius.circular(28))),
                                    child: FractionallySizedBox(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.library_books,
                                                color: Color(0xff4263EB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Anotações",
                                                style: TextStyle(
                                                  color: Color(0xff868E96),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 20,
                                                right: 20),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3,
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: AppStyle.mainColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  'Salvar anotação',
                                                  style: GoogleFonts.roboto(
                                                    color: Color(0xff4263EB),
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47),
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppStyle.mainColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                              ),
                                              onPressed: () {},
                                              label: Text(
                                                'Minhas anotações',
                                                style: GoogleFonts.roboto(
                                                  color: Color(0xff4263EB),
                                                ),
                                              ),
                                              icon: Icon(
                                                Icons.bookmark,
                                                color: Color(0xff364FC7),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 20,
                                                right: 20,
                                                top: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3,
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.library_books,
                                color: Color(0xff4263EB),
                              ),
                              SizedBox(width: 1),
                              Text(
                                "Anotações",
                                style: TextStyle(
                                  color: Color(0xff4263EB),
                                ),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            primary: AppStyle.mainColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(28)),
                                ),
                                backgroundColor: AppStyle.mainColor,
                                context: context,
                                builder: (BuildContext) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(28),
                                            topLeft: Radius.circular(28))),
                                    child: FractionallySizedBox(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.add,
                                                color: Color(0xff4263EB),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Favoritos",
                                                style: TextStyle(
                                                  color: Color(0xff868E96),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 20,
                                                right: 20),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3,
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: AppStyle.mainColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  'Salvar favoritos',
                                                  style: GoogleFonts.roboto(
                                                      color: Color(0xff4263EB)),
                                                )),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47),
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppStyle.mainColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                              ),
                                              onPressed: () {},
                                              label: Text(
                                                'Meus Favoritos',
                                                style: GoogleFonts.roboto(
                                                  color: Color(0xff4263EB),
                                                ),
                                              ),
                                              icon: Icon(
                                                Icons.bookmark,
                                                color: Color(0xff364FC7),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 20,
                                                right: 20,
                                                top: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 3,
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Color(0xff4263EB),
                              ),
                              SizedBox(width: 1),
                              Text(
                                "Favoritos",
                                style: TextStyle(
                                  color: Color(0xff4263EB),
                                ),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            primary: AppStyle.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: StartQuizz(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 10)));
                      },
                      child: Text("Atividade 1"))
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
