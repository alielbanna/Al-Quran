import 'dart:convert';
import 'dart:math';

import 'package:alquran/models/surahmodel.dart';
import 'package:alquran/screens/reading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data['chapters']) {
      surahList.add(Surah.fromMap(item));
    }
    debugPrint(surahList.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF064663),
      appBar: AppBar(
        title: Text(
          'Al-Quran Al-Karim - القرآن الكريم',
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Transform.rotate(
          angle: isReverse ? pi : 2 * pi,
          child: IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                setState(() {
                  isReverse = !isReverse;
                });
              }),
        ),
      ),
      body: surahList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFECB365),
              ),
            )
          : chaptersList(isReverse ? surahList.reversed.toList() : surahList),
    );
  }

  Widget chaptersList(List<Surah> chapters) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      controller: _controller,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFECB365),
          child: Text(
            chapters[index].id.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          chapters[index].name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          chapters[index].versesCount.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Text(
          chapters[index].arabicName,
          style: GoogleFonts.cairo(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                SurahPage(surah: chapters[index]),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Divider(
          height: 1.0,
          color: Colors.white,
        ),
      ),
      itemCount: chapters.length,
    );
  }
}
