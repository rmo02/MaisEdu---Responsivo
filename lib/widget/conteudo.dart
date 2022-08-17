import 'dart:convert';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List _atividade = [];
  List _aula=[];



  late Future<Disciplina> futureDisciplina;

  _pegarConteudo() async {
    var idDisciplina = this.widget.id;
    // print(idDisciplina);
    //pegando ID do aluno
    SharedPreferences idALuno = await SharedPreferences.getInstance();
    String id = idALuno.getString('id')!;
    // print(id);
    var conteudo =
        "http://192.168.6.20:3010/conteudosAluno/${id}/${widget.id}";
    var url = Uri.parse(conteudo);
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      // List<dynamic> data = map["conteudo"];
      print(map['conteudo']);
       setState(() {
         _conteudo = map["conteudo"];
         _atividade = map["conteudo"]['atividade'];
         _aula = map["conteudo"]['Aula'];
       });

      return map;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }


  @override
  void initState(){
    super.initState();
    _pegarConteudo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Container(
          child: ListView.builder(
            itemCount: _conteudo.length,
            itemBuilder: (context, index){
              return Container(
                child: Text(_conteudo[index]['name']),
              );
            },
          )
        )
    );
  }
}
