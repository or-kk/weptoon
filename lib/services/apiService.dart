import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weptoon/models/webtoon.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  Future<List<Webtoon>> getTodayToons() async {
    List<Webtoon> webtoonList = [];

    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        webtoonList.add(Webtoon.fromJson(webtoon));
      }

      return webtoonList;
    }

    throw Error();
  }
}
