
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:resposividade/pages/bar_item_page.dart';
import 'package:resposividade/services/prefs_service.dart';
import '../style/app_style.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //login - tentativa 100
  TextEditingController _matController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void login(String mat, String password) async {
    try {
      Response response = await post(
        Uri.parse('http://192.168.6.20:3010/escolas/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'mat': mat,
          'password': password
        }),
      );

      if (response.statusCode == 200) {
        var dados = jsonDecode(response.body);
        PrefsService.save(dados['token']);
        Navigator.push(context, PageTransition(child: BarItemPage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 10)
        ));
        ElegantNotification.success(
            title:  Text("Update"),
            description:  Text("Your data has been updated")
        ).show(context);
      } else {
        ElegantNotification.error(
            title:  Text("Error"),
            description:  Text("Usuário ou senha inválidos")
        ).show(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }
@override
void initState() {
    super.initState();
  Future.wait([
    PrefsService.isAuth(),
    Future.delayed(Duration(seconds: 3)),
  ]).then((value) => value[0]
      ? Navigator.of(context).pushReplacementNamed('/login')
      : Navigator.of(context).pushReplacementNamed('/home'));

}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyle.secondColor,
      body: LayoutBuilder(
          builder: (_,constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 50.0),
                        child: Image.asset("assets/images/logo-educacao.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 10.0, left: 30.0, right: 30.0),
                        child: TextField(

                          controller: _matController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "753.145.574-01",
                            labelStyle: TextStyle(
                                fontSize: 24,
                                color: Colors.black26
                            ),
                            border: UnderlineInputBorder(
                                borderRadius:BorderRadius.circular(8.0)),
                          ),
                          obscureText: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "*******************",
                            labelStyle: TextStyle(
                                fontSize: 28 ,
                                color: Colors.black26
                            ),
                            border: UnderlineInputBorder(
                                borderRadius:BorderRadius.circular(8.0)),
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(
                          "Esqueceu sua senha?",
                          style: GoogleFonts.roboto(
                              color: Colors.white70
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: constraints.maxWidth * 0.70,
                        height: constraints.maxHeight * 0.07,
                        child: ElevatedButton(
                          onPressed: (){
                            login(_matController.text, _passwordController.text);
                            },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff364fc7)
                          ),
                          child: Container(
                            child: Text("Entrar", style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                            ),),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

            );
          }
      ),
    );
  }
}