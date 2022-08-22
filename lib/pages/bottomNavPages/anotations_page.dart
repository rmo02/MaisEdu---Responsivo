import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:resposividade/pages/anotations/create_anotation.dart';
import 'package:resposividade/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/app_style.dart';

class AnotationPage extends StatefulWidget {
  const AnotationPage({Key? key}) : super(key: key);

  @override
  State<AnotationPage> createState() => _AnotationPageState();

}
List _anotacoes = [];

class _AnotationPageState extends State<AnotationPage> {
  _getAnotations() async {
    SharedPreferences idALuno = await SharedPreferences.getInstance();
    String id = idALuno.getString('id')!;
    List<dynamic> values = id.split("Id ");
    var url = Uri.parse('http://192.168.6.20:3010/anotacoesByAluno/${values[0]}');
    var resposta = await http.get(url);
    if (resposta.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      List<dynamic> data = map["anotacoes"];
      setState(() {
        _anotacoes = data;
      });
      print(data);
      return data;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAnotations();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.secondColor,
        elevation: 0,
        title: Text("Minhas Anotações", style: GoogleFonts.roboto(
            fontSize: 18,
          ),
          textAlign: TextAlign.center
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 25,
              color: Colors.white,
            ),
          ),
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
                    child: LoginPage(),
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
      body: LayoutBuilder(builder: (_, constraints) {
        return Container(
          height: constraints.maxHeight,
          child:  ListView.builder(
            shrinkWrap: true,
            itemCount: _anotacoes.length,
            itemBuilder: (context, int index){
              return  Column(
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                          width: constraints.maxWidth * 0.90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                _anotacoes[index]["descricao"],
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.black54),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(_anotacoes[index]["tags"][0]),

                                  ],
                                )
                              )
                            ],
                          )),
                    )
                  ],
                );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        focusColor: AppStyle.secondColor,
        backgroundColor: AppStyle.secondColor,
        elevation: 2,
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: CreateAnotation(),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 10)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
