import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:resposividade/modules/tag_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/app_style.dart';


var suggestTag = [
  "Matemática",
  "Português",
  "Física",
  "Química",
  "Inglês",
  "Espanhol",
  "Biologia",
  "Geografia",
];

class CreateAnotation extends StatefulWidget {
  const CreateAnotation({Key? key}) : super(key: key);



  @override
  State<CreateAnotation> createState() => _CreateAnotationState();
}

class _CreateAnotationState extends State<CreateAnotation> {

  final controller = Get.put(TagStateController());
  TextEditingController textController = TextEditingController();


  TextEditingController _anotacoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.secondColor,
        elevation: 0,
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
            onPressed: () {},
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
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 15,
                decoration: BoxDecoration(
                  color: AppStyle.secondColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: AppStyle.shadowMainColor,
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0.0, 2.0)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                child: AutoSizeText(
                  "Minhas Anotações",
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    color: AppStyle.titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                    controller: _anotacoesController,
                    expands: true,
                    maxLines: null,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusColor: AppStyle.titleColor,
                      fillColor: AppStyle.titleColor,
                    ),
                  ),
                ),
              )),
              Container(
                decoration: BoxDecoration(color: AppStyle.mainColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: constraints.maxWidth * .25),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(28),
                                    topLeft: Radius.circular(28))),
                            backgroundColor: Color(0xffF1F3F5),
                            context: context,
                            builder: (context) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.95,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 30, top: 50),
                                        child: Text(
                                          "Adicionar Tags",
                                          style: GoogleFonts.roboto(
                                              color: AppStyle.secondColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TypeAheadField(
                                                suggestionsBoxDecoration:
                                                    SuggestionsBoxDecoration(
                                                  elevation: 2.0,
                                                ),
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                  controller: textController,
                                                  onEditingComplete: () {
                                                    controller.ListTags.add(textController.text);
                                                    textController.clear();
                                                  },
                                                  autofocus: false,
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style
                                                      .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                  decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      border:
                                                          UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      hintText: 'Nova tag'),
                                                ),
                                                suggestionsCallback:
                                                    (String pattern) {
                                                  return suggestTag.where((e) =>
                                                      e.toLowerCase().contains(
                                                          pattern
                                                              .toLowerCase()));
                                                },
                                                itemBuilder:
                                                    (BuildContext context,
                                                        String itemData) {
                                                  return ListTile(
                                                    leading: Icon(
                                                      Icons.tag,
                                                      color: Color(0xff403B91),
                                                    ),
                                                    focusColor:
                                                        Color(0xff403B91),
                                                    title: Text(
                                                      itemData,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff403B91)),
                                                    ),
                                                  );
                                                },
                                                onSuggestionSelected:
                                                    (String suggestion) =>
                                                        controller.ListTags.add(
                                                            suggestion)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Obx(() => controller
                                                      .ListTags.length ==
                                                  0
                                              ? Center(
                                                  child: Text(
                                                    'Sem tags selecionadas',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff4263EB)),
                                                  ),
                                                )
                                              : Wrap(
                                                  children: controller.ListTags
                                                      .map((element) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            child: Chip(
                                                              label: Text(
                                                                element,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff4263EB),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  AppStyle
                                                                      .mainColor,
                                                              elevation: 3,
                                                              deleteIcon: Icon(
                                                                  Icons.clear),
                                                              onDeleted: () =>
                                                                  controller
                                                                          .ListTags
                                                                      .remove(
                                                                          element),
                                                            ),
                                                          )).toList(),
                                                ))
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Row(
                        children: [Icon(Icons.add), Text("Adicionar Tags")],
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: AppStyle.mainColor,
                          primary: Color(0xFF4263EB)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        postAnotacoes();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 5),
                          Text("Salvar")
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          primary: AppStyle.secondColor),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        );

      }),
    );
  }



  Future<bool> postAnotacoes() async {
    print(controller.ListTags);
    SharedPreferences idALuno = await SharedPreferences.getInstance();
    String id = idALuno.getString('id')!;
    List<dynamic> values = id.split("Id ");


    var anotacoes = "http://192.168.6.20:3010/anotacoes";
    var url = Uri.parse(anotacoes);
    var resposta = await http.post(url,
    headers: <String, String>{
      "Content-Type": "application/json"
    },
      body: jsonEncode(<String,String>{
        "descricao" : _anotacoesController.text,
        "id_aluno" : "${values[0]}",
        "array_tags": '[mtm]'
      })
    );
    if (resposta.statusCode == 200){
      ElegantNotification.success(description:Text('Anotação salva')).show(context);
      return true;
    } else {
      ElegantNotification.error(description:Text('Erro ao salvar, revise o texto ou as tags')).show(context);
      return false;
    }
  }
}

