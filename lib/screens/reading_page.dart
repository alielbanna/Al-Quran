import 'package:alquran/models/surahmodel.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class SurahPage extends StatelessWidget {
  final Surah surah;
  const SurahPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    int count = surah.versesCount;
    int index = surah.id;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF064663),
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.all(15.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: header(),
              ),
              const SizedBox(
                height: 5.0,
              ),
              RichText(
                textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
                text: TextSpan(
                  style: const TextStyle(
                    height: 2.0,
                  ),
                  children: [
                    for (var i = 1; i <= count; i++) ...{
                      TextSpan(
                        text:
                            ' ${quran.getVerse(index, i, verseEndSymbol: false)} ',
                        style: const TextStyle(
                          fontFamily: 'Kitab',
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFECB365),
                          radius: 14.0,
                          child: Text(
                            '$i',
                            textAlign: TextAlign.center,
                            textScaleFactor: i.toString().length <= 2 ? 1 : 0.8,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          surah.arabicName,
          style: const TextStyle(
            fontFamily: 'Aldhabi',
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFECB365),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          ' ${quran.basmala} ',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'NotoNastaliqUrdu',
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
