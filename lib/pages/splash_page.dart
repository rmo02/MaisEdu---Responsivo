import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:resposividade/style/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
      verificarToken().then((value) {
        Duration(seconds: 3);
       if(value){
         Navigator.pushReplacementNamed(context, '/home');
       }else{
         Navigator.pushReplacementNamed(context, '/login');
       }
     });

    //Future.delayed(Duration(seconds: 3)).
    //then((_) => Navigator.of(context).pushReplacementNamed('/login'));

  }

  @override
  Widget build(BuildContext context) {
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
                    ],
                  ),
                ),
              ),

            );
          }
      ),
    );
  }

  Future <bool> verificarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('token') != null){
      return true;
    }else {
      return false;
    }
  }
}