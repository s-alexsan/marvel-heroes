import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel_heroes/server/colors.dart';
import 'package:marvel_heroes/server/functions.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Character extends StatefulWidget {
  final Map<String, dynamic> data;
  const Character(this.data, {Key? key}) : super(key: key);

  @override
  CcharacterState createState() => CcharacterState();
}

class CcharacterState extends State<Character> {
  Map<String, dynamic> dataCharacted = {};

  @override
  void initState() {
    dataCharacted = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 30,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SvgPicture.asset(
              'assets/icons/back.svg',
              color: primarySilver,
            ),
          ),
        ),
        backgroundColor: const Color(0x44000000),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(dataCharacted['imagePath']),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height / 3, 20, 8),
          children: [
            Text(
              dataCharacted['alterEgo'],
              style: TextStyle(
                color: primaryGrey,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                dataCharacted['name'],
                style: TextStyle(color: primaryWhite, fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  caracteristics(
                      "age", "${convertYear2Age(dataCharacted['caracteristics']['birth'])} anos"),
                  caracteristics("weight",
                      "${dataCharacted['caracteristics']['weight']['value']}${dataCharacted['caracteristics']['weight']['unity']}"),
                  caracteristics("height",
                      "${dataCharacted['caracteristics']['height']['value']}${dataCharacted['caracteristics']['height']['unity'].toString()[0]}"),
                  caracteristics("universe", dataCharacted['caracteristics']['universe']),
                ],
              ),
            ),
            Text(
              dataCharacted['biography'],
              style: TextStyle(color: primarySilver, fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                'Habilidades',
                style: TextStyle(color: primarySilver, fontSize: 16),
              ),
            ),
            abilities(context, 'force'),
            abilities(context, 'intelligence'),
            abilities(context, 'agility'),
            abilities(context, 'endurance'),
            abilities(context, 'velocity'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                'Filmes',
                style: TextStyle(color: primarySilver, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dataCharacted['movies'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Image.asset(
                        dataCharacted['movies'][index],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding abilities(BuildContext context, String abilities) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translate(abilities),
            style: TextStyle(color: primarySilver, fontSize: 12),
          ),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width / 1.5,
            lineHeight: 14.0,
            percent: dataCharacted['abilities'][abilities] / 100,
            backgroundColor: const Color(0x44000000),
            progressColor: primarySilver,
          )
        ],
      ),
    );
  }

  Column caracteristics(String svg, String text) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/$svg.svg',
          color: primaryGrey,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            text,
            style: TextStyle(color: primaryWhite, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
