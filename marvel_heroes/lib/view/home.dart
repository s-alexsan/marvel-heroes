import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel_heroes/server/colors.dart';
import 'package:marvel_heroes/server/functions.dart';
import 'package:marvel_heroes/view/character.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      appBar: AppBar(
        toolbarOpacity: 0,
        bottomOpacity: 0,
        title: SizedBox(
          height: 20,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                center: Alignment.topCenter,
                colors: [gradientRedFromTop, gradientRedToBottom],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: SvgPicture.asset(
              'assets/icons/marvel.svg',
              color: gradientRedFromTop,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bem vindo Marvel Heroes",
              style: TextStyle(fontSize: 14),
            ),
            const Text(
              "Escolha o seu personagem",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  icon(gradientBlueFromTop, gradientBlueToBottom, "hero"),
                  icon(gradientRedFromTop, gradientRedToBottom, "villain"),
                  icon(gradientPurpleFromTop, gradientPurpleToBottom, "antihero"),
                  icon(gradientGreenFromTop, gradientGreenToBottom, "alien"),
                  icon(gradientPinkFromTop, gradientPinkToBottom, "human"),
                ],
              ),
            ),
            FutureBuilder(
              future: getJson(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Card(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      personagem(snapshot, 'heroes'),
                      personagem(snapshot, 'villains'),
                      personagem(snapshot, 'antiHeroes'),
                      personagem(snapshot, 'aliens'),
                      personagem(snapshot, 'humans'),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget personagem(AsyncSnapshot<dynamic> snapshot, String category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate(category),
            style: TextStyle(fontSize: 18, color: primaryRed),
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data[category].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => Character(snapshot.data[category][index]),
                    ),
                  ),
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      fit: StackFit.loose,
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.asset(
                            snapshot.data[category][index]['imagePath'],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data[category][index]['alterEgo'],
                                style: TextStyle(
                                  color: primaryWhite,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  snapshot.data[category][index]['name'],
                                  style: TextStyle(color: primaryWhite, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container icon(Color color1, Color color2, String svg) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SvgPicture.asset(
        'assets/icons/$svg.svg',
        height: 40,
        color: primaryWhite,
      ),
    );
  }
}
