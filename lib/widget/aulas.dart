import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/interfaces/atv.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:resposividade/style/app_style.dart';

class Aulas extends StatefulWidget {
  const Aulas({Key? key}) : super(key: key);

  @override
  State<Aulas> createState() => _AulasState();
}

class _AulasState extends State<Aulas> {


List _aulas = [];

  pegarAulas() async {
    var url = Uri.parse(
        'http://192.168.6.20:3010/aulas/series/2c4c4950-8bad-41ed-970d-d32546baea2c/31d9ef2d-0dc8-4108-8549-ddd6d117e7c5');
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      List<dynamic> data = map["aulas"];
        _aulas = data;
        print(_aulas);
      return data;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }

// late final BetterPlayerController _betterPlayerController;
//
// @override
// void initState() {
//   super.initState();
//   BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       _aulas.map((e) {
//         print(e["file"]);
//         return e['file'];
//
//       }).toString(),
//     cacheConfiguration: BetterPlayerCacheConfiguration(
//       useCache: true,
//       preCacheSize: 10 * 720 * 720,
//       maxCacheSize: 10 * 1024 * 1024,
//       maxCacheFileSize: 10 * 1024 * 1024,
//       key: 'testeChacheKey',
//     )
//   );
//   _betterPlayerController = BetterPlayerController(
//       BetterPlayerConfiguration(),
//       betterPlayerDataSource: betterPlayerDataSource);
// print(_aulas);
// }
//
// @override
// void dispose(){
//   _betterPlayerController.dispose();
//   super.dispose();
//
// }


  List<Atv> atvs = [
    Atv(1, "Aula 1", "Aula 1 sobre matemática básica", false),
    Atv(2, "Aula 2", "Aula 2 sobre a trigonometria", false),
  ];

  bool _playArea = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
              //height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(
            color: AppStyle.secondColor
          ),

          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 20,
                          color: Colors.white,
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
                        FutureBuilder<dynamic>(
                          future: pegarAulas(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      var aulas = snapshot.data![index];
                                      return GestureDetector(
                                        onTap: (){
                                          debugPrint(aulas.toString());
                                          setState(() {
                                            if(_playArea == false){
                                              _playArea=true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 100,
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          child: Column(
                                            children: [
                                              _playArea == false ? Row(
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
                                              ) : Container(),
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
                                        ),
                                      );
                                    }),
                              );
                            }
                            return const Center(child: CircularProgressIndicator());
                          },
                        )
                      ],
                    ),
                ),
              )

            ],
          ),
      )
    );
  }

}