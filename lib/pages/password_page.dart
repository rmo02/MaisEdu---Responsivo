import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:resposividade/pages/config_page.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordPage extends StatefulWidget {

  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  TextEditingController _novoPassword1 = TextEditingController();
  TextEditingController _novoPassword2 = TextEditingController();
  TextEditingController _atualPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Container(
          width: 120,
          height: 60,
          child: Image.asset('assets/images/logo-educacao.png',),
        ),
        backgroundColor: AppStyle.secondColor,
        elevation: 0,
        actions: [

          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none_outlined,
            size: 25,
            color: Colors.white,
          ),
          ),
          IconButton(onPressed: (){}, icon: const Icon(Icons.person,
            size: 25,
            color: Colors.white,
          ),
          ),
        ],
      ),
      backgroundColor: AppStyle.mainColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: AppStyle.mainColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: AppStyle.secondColor,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: AppStyle.shadowMainColor,
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0.0, 2.0)
                      ),
                    ],
                  ),
                ),  //Decoração appBar
                Container(
                  child: const Text("Configurações", style: TextStyle(
                      color: Color(0xff403B91),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"
                  ),
                  ),
                  padding: EdgeInsets.only(top: 10, left: 20,),
                ),
                Container(
                  child: const Text("Senha atual", style: TextStyle(
                      color: Color(0xff403B91),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"
                  ),
                  ),
                  padding: EdgeInsets.only(top: 20, left: 20),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: SizedBox(
                    height: 50,
                    width: 380,
                    child: TextFormField(
                      validator: (senha){
                        if(senha == null || senha.isEmpty){
                          return 'Por favor, Digite a senha';
                        }
                        return null;
                      },
                      controller: _atualPassword,
                      decoration: InputDecoration(
                        hintText: "**********",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0,),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: const Text("Nova senha", style: TextStyle(
                      color: Color(0xff403B91),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"
                  ),
                  ),
                  padding: EdgeInsets.only(top: 20, left: 20),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: SizedBox(
                    height: 50,
                    width: 380,
                    child: TextFormField(
                      validator: (senha){
                        if(senha == null || senha.isEmpty){
                          return 'Por favor, Digite a senha';
                        }
                        return null;
                      },
                      controller: _novoPassword1,
                      decoration: InputDecoration(
                        hintText: "**********",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0,),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: const Text("Confirmar nova senha", style: TextStyle(
                      color: Color(0xff403B91),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"
                  ),
                  ),
                  padding: EdgeInsets.only(top: 20, left: 20),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: SizedBox(
                    height: 50,
                    width: 380,
                    child: TextFormField(
                      validator: (senha){
                        if(senha == null || senha.isEmpty){
                          return 'Por favor, Digite a senha';
                        }
                        return null;
                      },
                      controller: _novoPassword2,
                      decoration: InputDecoration(
                        hintText: "**********",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 10),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      ElevatedButton(onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            fixedSize: Size(170, 50), primary: Color(0xffBAC8FF),
                          ),
                          child: Text('Cancelar', style: TextStyle(
                              color: Color(0xff4263EB),
                              fontSize: 18,
                              fontFamily: 'Roboto'),)),
                      SizedBox(width: 10,),
                      ElevatedButton(
                          onPressed: ()  {
                            if (_novoPassword1.text == _novoPassword2.text){
                              changePassword();
                            }
                            else {
                              return print('Errad');
                            }


                      },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            fixedSize: Size(170, 50), primary: Color(0xff4263EB),
                          ),
                          child: Text('Confirmar', style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Future<bool> changePassword () async {
  SharedPreferences idSenha = await SharedPreferences.getInstance();
  String id = idSenha.getString('id_senha')!;
  print(id);
  List<dynamic> values = id.split("Id ");
  var url = Uri.parse('http://192.168.6.20:3010/escolas/users/change_password');
  Response response = await put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept' : 'application/json'
    },
    body: jsonEncode(<String, String> {
      'actual_password' : _atualPassword.text,
      'new_password': _novoPassword2.text,
      'id_user': "${values[0]}"
    }),
  );
  if (response.statusCode == 200){
  print('deu certo');
    return true;
  } else {
    print('deu errado');
    return false;
  }
}

}
