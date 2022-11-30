import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quran_flutter/surah.dart';

// abstract class SurahService{
//   Future<List<Surah>> fetchSurah();
// }

class SurahImpl {
  static final SurahImpl _singleton = SurahImpl._internal();

  factory SurahImpl() {
    return _singleton;
  }

  SurahImpl._internal();

  // @override
  Future<List<Surah>> fetchSurah() async{
    final response= await rootBundle.loadString('assets/surahs.json');
    final List data = await json.decode(response);
    final List<Surah> surahs= data.map((e) => Surah.fromJson(e)).toList();
    return surahs;
  }

}