import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonid,
  });

  final WebtoonEpisodeModel episode;
  final String webtoonid;

  onButtonTap() async {
    // launch는 future 을 주는 함수이므로 await해야함
    // url연결과 마찬가지로 사용할곳에 GestureDetector위젯 추가
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonid&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.shade300,
          boxShadow: [
            BoxShadow(
              // 그림자 효과
              blurRadius: 2,
              offset: const Offset(4, 4),
              color: Colors.black.withOpacity(0.3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(episode.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
