import 'dart:convert';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/interfaces/atv.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class Aulas extends StatefulWidget {
  const Aulas({Key? key}) : super(key: key);

  @override
  State<Aulas> createState() => _AulasState();
}

class _AulasState extends State<Aulas> {

var _aulas = [];

  pegarAulas() async {
    var url = Uri.parse(
        'http://192.168.6.20:3010/aulas/series/2c4c4950-8bad-41ed-970d-d32546baea2c/31d9ef2d-0dc8-4108-8549-ddd6d117e7c5');
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      List<dynamic> data = map["aulas"];
        _aulas = data;
      return data;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }

  List<Atv> atvs = [
    Atv(1, "Aula 1", "Aula 1 sobre matemática básica", false),
    Atv(2, "Aula 2", "Aula 2 sobre a trigonometria", false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<dynamic>(
          future: pegarAulas(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var aulas = snapshot.data![index];

                    return ExpansionTileCard(
                      initiallyExpanded: index == 0,
                      title: Text(aulas['title']),
                      children: [
                        Divider(
                          thickness: 1.0,
                        ),
                        BetterPlayer.network(aulas['file'],betterPlayerConfiguration: BetterPlayerConfiguration(
                          autoDispose: false,
                          autoPlay: false,
                          looping: false,
                          aspectRatio: 16/9,
                        )),
                      ],

                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

}
