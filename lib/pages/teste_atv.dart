import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resposividade/interfaces/atv.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

class TestePage extends StatefulWidget {
  const TestePage({Key? key}) : super(key: key);

  @override
  State<TestePage> createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {

  late final BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        notificationConfiguration: BetterPlayerNotificationConfiguration(
          showNotification: true,
          activityName: 'MainActivy',
          imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg',
        ),
        "https://cdn.jmvstream.com/vod/vod_10807/f/q0yj22rl2jc56df/h/4/playlist.m3u8");
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  List<Atv> atvs = [
    Atv(1, "Aula 1", "Aula 1 sobre matemática básica", false),
    Atv(2, "Aula 2", "Aula 2 sobre a trigonometria", false),
  ];



  @override
  Widget build(BuildContext context) {
    return Column(
      children: atvs.map((atv) {
        return Container(
         child: RoundedExpansionTile(),
        );
      }).toList(),
    );
  }
}
