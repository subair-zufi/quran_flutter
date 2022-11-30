import 'package:flutter/material.dart';
import 'package:quran_flutter/quran_page.dart';
import 'package:quran_flutter/surah.dart';
import 'package:quran_flutter/surah_service.dart';

class SurahPage extends StatelessWidget {
  const SurahPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah'),
      ),
      body: FutureBuilder<List<Surah>>(
        future: SurahImpl().fetchSurah(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (_, index) {
                  final Surah surah = snapshot.data![index];
                  return ListTile(
                    title: Text(surah.titleAr ?? "Surah"),
                    trailing: Text(surah.pages ?? ''),
                    leading: Text(surah.index.toString()),
                    subtitle: Text(surah.title ?? ""),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => QuranPage(
                                    initialPage: int.parse(surah.pages??"0"),
                                  )));
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: snapshot.data!.length);
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
