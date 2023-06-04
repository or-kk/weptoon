import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weptoon/models/webtoon.dart';
import 'package:weptoon/models/webtoonDetail.dart';
import 'package:weptoon/models/webtoonEpisode.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<Webtoon>> getTodayToons() async {
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

  static Future<WebtoonDetail> getTodayById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetail.fromJson(webtoon);
    }

    throw Error();
  }

  static Future<List<WebtoonEpisode>> getLatestEpisodeById(String id) async {
    List<WebtoonEpisode> episodeList = [];

    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeList.add(WebtoonEpisode.fromJson(episode));
      }
      return episodeList;
    }

    throw Error();
  }
}
