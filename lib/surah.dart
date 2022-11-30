class Surah {
  String? place;
  String? type;
  int? count;
  String? title;
  String? titleAr;
  String? index;
  String? pages;
  List<Juz>? juz;

  Surah(
      {this.place,
        this.type,
        this.count,
        this.title,
        this.titleAr,
        this.index,
        this.pages,
        this.juz});

  Surah.fromJson(Map<dynamic, dynamic> json) {
    place = json['place'];
    type = json['type'];
    count = json['count'];
    title = json['title'];
    titleAr = json['titleAr'];
    index = json['index'];
    pages = json['pages'];
    if (json['juz'] != null) {
      juz = <Juz>[];
      json['juz'].forEach((v) {
        juz!.add(Juz.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place'] = place;
    data['type'] = type;
    data['count'] = count;
    data['title'] = title;
    data['titleAr'] = titleAr;
    data['index'] = index;
    data['pages'] = pages;
    if (juz != null) {
      data['juz'] = juz!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Juz {
  String? index;
  Verse? verse;

  Juz({this.index, this.verse});

  Juz.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    verse = json['verse'] != null ? Verse.fromJson(json['verse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    if (verse != null) {
      data['verse'] = verse!.toJson();
    }
    return data;
  }
}

class Verse {
  String? start;
  String? end;

  Verse({this.start, this.end});

  Verse.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}

