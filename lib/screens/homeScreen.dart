import 'package:flutter/material.dart';
import 'package:weptoon/services/ApiService.dart';
import 'package:weptoon/widgets/webtoonWidget.dart';

import '../models/webtoon.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Future<List<Webtoon>> webtoons = ApiService.getTodayToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, future) {
          if (future.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(future),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<Webtoon>> future) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: future.data!.length,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        itemBuilder: (BuildContext context, int index) {
          var webtoon = future.data![index];

          return WebtoonWidget(
            title: webtoon.title,
            thumb: webtoon.thumb,
            id: webtoon.id,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
              width: 40,
            ));
  }
}
