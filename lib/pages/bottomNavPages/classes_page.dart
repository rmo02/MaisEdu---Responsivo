import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:resposividade/pages/bottomNavPages/perfil_page.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/widget/aulas.dart';
import '../../style/app_style.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {

  List _disciplinas = [];

  _GetDisciplinas() async {
    SharedPreferences idALuno = await SharedPreferences.getInstance();
    String id = idALuno.getString('id')!;
    List<dynamic> values = id.split("Id ");
    var url = Uri.parse('http://192.168.6.20:3010/disciplinasAluno/${values[0]}');
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(resposta.body);
      List<dynamic> data = map["disciplinas"];
      setState(() {
        _disciplinas = data;
      });

      return data;
    } else {
      throw Exception('Nao foi possivel carregar usuários');
    }
  }

  @override
  void initState() {
    super.initState();
    _GetDisciplinas();
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
        body: LayoutBuilder(builder: (_, constraints) {
          if (constraints.maxWidth < 389) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 0),
                  itemCount: _disciplinas.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                          color: Colors.transparent),
                      margin: EdgeInsets.all(2),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => Aulas(id: _disciplinas[index]['disciplina']['id'])
                                      ));
                                },
                                child: Container(
                                  height: 150,
                                    child: Image.asset(
                                        'assets/images/calculadora.png'
                                      // _disciplinas[index]['disciplina']['icon'],
                                    )),
                              ),
                              Container(
                                width: 150,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                  color: Colors.white
                                ),
                                child: Center(
                                  child: Text(_disciplinas[index]["disciplina"]['name'],
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    );

                  }),

            );
          } else {
            return  MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 0),
                  itemCount: _disciplinas.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      width: 170,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                          color: Colors.transparent),
                      margin: EdgeInsets.all(2),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => Aulas(id: _disciplinas[index]['disciplina']['id'])
                                      ));
                                },
                                child: Container(
                                    child: Image.network(
                                      _disciplinas[index]['disciplina']['icon'],
                                    )),
                              ),
                              Container(
                                width: 150,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                    color: Colors.white
                                ),
                                child: Center(
                                  child: Text(_disciplinas[index]["disciplina"]['name'],
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    );
                  }),

                  );

                }

              },

            ),
      );
          }
  }

