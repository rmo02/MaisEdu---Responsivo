import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:resposividade/pages/bottomNavPages/perfil_page.dart';
import 'package:resposividade/pages/login_page.dart';
import 'package:resposividade/style/app_style.dart';

class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: 120,
            height: 60,
            child: Image.asset('assets/images/logo-educacao.png',),
            ),
            backgroundColor: AppStyle.secondColor,
            elevation: 0,
            actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search,
            size: 25,
            color: Colors.white,
            ),
            ),

            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined,
            size: 25,
            color: Colors.white,
            ),
            ),
            IconButton(onPressed: () => Navigator.push(context, PageTransition(
            child: PerfilPage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 10)
            )), icon: Icon(Icons.person,
            size: 25,
            color: Colors.white,
            ),
            ),
            ],

            ),
            backgroundColor: AppStyle.mainColor,
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.47,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: AppStyle.shadowMainColor,
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(0.0, 2.0)
                        ),
                      ],
                      color: AppStyle.secondColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28))
                  ),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 50),
                      child: Image.asset('assets/images/banner.png',),
                    ),
                  ),
                ),
                Container(
                  child: Positioned(
                    top: MediaQuery.of(context).size.height * 0.38,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: constraints.maxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(padding: EdgeInsets.only(top: 10, left: 10),
                              child:  Text("Últimas Aulas",
                                  style: GoogleFonts.roboto(
                                      color: AppStyle.titleColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            height: 120,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(left: 30, right: 3),
                              children: [
                                Container(
                                  height: 125,
                                  width: 170,
                                  margin: EdgeInsets.all(5),
                                  child: Center(
                                    child: Image.asset('assets/images/biomas.png'),
                                  ),
                                ),
                                Container(
                                  height: 125,
                                  width: 170,
                                  margin: EdgeInsets.all(5),
                                  child: Center(
                                    child: Image.asset('assets/images/angulos.png'),
                                  ),
                                ),
                                Container(
                                  height: 125,
                                  width: 170,

                                  margin: EdgeInsets.all(5),
                                  child: Center(
                                    child: Image.asset('assets/images/adverbio.png'),
                                  ),
                                ),

                                Container(
                                  width: 185,
                                  child: Center(
                                    child: Image.asset('assets/images/banner2.png',
                                      height: 170,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Padding(padding: EdgeInsets.only(top: 9, left: 10),
                              child:  Text("Últimas Aulas",
                                  style: GoogleFonts.roboto(
                                      color: AppStyle.titleColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            height: 120,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(left: 30, right: 3),
                              children: [
                                Container(
                                  height: 125,
                                  width: 170,
                                  margin: EdgeInsets.all(5),
                                  child: Center(
                                    child: Image.asset('assets/images/biomas.png'),
                                  ),
                                ),
                                Container(
                                  height: 125,
                                  width: 170,
                                  margin: EdgeInsets.all(5),
                                  child: Center(
                                    child: Image.asset('assets/images/angulos.png'),
                                  ),
                                ),
                                Container(
                                  height: 125,
                                  width: 170,

                                  margin: EdgeInsets.all(5),
                                  child: Center(
                                    child: Image.asset('assets/images/adverbio.png'),
                                  ),
                                ),

                                Container(
                                  width: 185,
                                  child: Center(
                                    child: Image.asset('assets/images/banner2.png',
                                      height: 170,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
);
  }
}
