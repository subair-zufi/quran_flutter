import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PageServiceImpl {
  bool inProgress = false;

  Future saveNext5Pages(int initialPage) async {
    if (!inProgress) {
      inProgress = true;
      final pageNums = List.generate(5, (index) => initialPage + index);
      for (int pageNum in pageNums) {
        final pageNumString = pageNum.toString().padLeft(3, "0");
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          final file = File(join(directory.path, "$pageNumString.png"));
          final fileExists = await file.exists();
          if (fileExists){
            print('conrinued $pageNum');
            continue;
          }
          final response = await get(Uri.parse(
              "http://quran.islam-db.com/data/pages/quranpages_1024/images/page$pageNumString.png"));

          await file.writeAsBytes(response.bodyBytes);
          print('wrote $pageNum');
          inProgress = false;
        }
      }
    }else{
      return;
    }
  }

  Future<File?> readQuranPage(int pageNum) async {
    final directory = await getExternalStorageDirectory();
    final file = File(join(directory!.path,"${pageNum.toString().padLeft(3, "0")}.png"));
    final fileExists = await file.exists();
    print("file exist $fileExists");
    if (fileExists) {
      return file;
    } else {
      saveNext5Pages(pageNum);
      return null;
    }
  }
}
