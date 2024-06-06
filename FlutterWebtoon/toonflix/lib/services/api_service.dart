import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  // 비동기 처리를 위한 어싱크
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    // 보낼 주소를 설정
    final url = Uri.parse('$baseUrl/$today');
    // API 요청 - await로 비동기 처리
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  // 미래에 받겠다<이 파일의 형식으로> 파일 이름(받을 타입)
  static Future<WebtoonDetailModel> getToonById(String id) async {
    // URL 주소 지정
    final url = Uri.parse("$baseUrl/$id");
    // 요청 보내기
    final response = await http.get(url);
    // 200 즉 응답있음
    if (response.statusCode == 200) {
      // 디코드 과정 변수에 디코딩 해서 저장
      final webtoon = jsonDecode(response.body);
      // 디코딩한 파일을 WebtoonDetailModel로 전달
      return WebtoonDetailModel.fromJson(webtoon);
    } else {
      throw Error();
    }
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    // URL 주소 지정
    final url = Uri.parse("$baseUrl/$id/episodes");
    // 요청 보내기
    final response = await http.get(url);
    // 200 즉 응답있음
    if (response.statusCode == 200) {
      // 디코드 과정 변수에 디코딩 해서 저장
      final episodes = jsonDecode(response.body);
      // 에피소드들을 반복문을 돌려서 하나하나 생성
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    } else {
      throw Error();
    }
  }
}
