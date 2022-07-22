import 'package:flutter/material.dart';
import 'package:resposividade/style/app_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

  Future.delayed(Duration(seconds: 3)).
  then((_) => Navigator.of(context).pushReplacementNamed('/login'));

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
}
