import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_flutter/page_service.dart';

class QuranPage extends StatefulWidget {
  final int initialPage;

  const QuranPage({Key? key, required this.initialPage}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  late PageController _controller;
  late int _currentPage;
  @override
  void initState() {
    _controller= PageController(initialPage: widget.initialPage);
    _currentPage= widget.initialPage;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: 605,
          controller: _controller,
          reverse: true,
          itemBuilder: (_, index) {
            int pageNum = widget.initialPage+(index-widget.initialPage);
            return QuranPageView(pageNum: pageNum);
          },
      onPageChanged: (index){
            // print(pageNum);
            // _controller.page= pageNum;
      },),
    );
  }
}

class QuranPageView extends StatefulWidget {
  final int pageNum;

  const QuranPageView({Key? key, required this.pageNum}) : super(key: key);

  @override
  State<QuranPageView> createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
  late String pageNumString;

  @override
  void initState() {
    pageNumString = "${widget.pageNum}".padLeft(3, "0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
        future: PageServiceImpl().readQuranPage(widget.pageNum),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            print("file");
            return Image.file(snapshot.data!);
          } else if (snapshot.data == null) {
            print('url');

            return Image.network(
                "http://quran.islam-db.com/data/pages/quranpages_1024/images/page$pageNumString.png");
          }
          return const LinearProgressIndicator();
        });
  }
}
