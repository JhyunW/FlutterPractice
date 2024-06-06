import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('온탭 실행');
        Navigator.push(
          // 이동 효과를 줘서 페이지를 이동했다는 효과를 줄 수 있음
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
            fullscreenDialog: false, // false면 페이지, true면 모달 개념
          ),
        ); // route는 stl을 애니메이션으로 감싸서 스크린처럼 보이게 하는것
      },
      child: Column(
        children: [
          // 이미지의 크기 조정을 위해 컨테이너로 묶어줌
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge, // 이미지의 양역 침범을 조정
              decoration: // 이미지 라디우스 추가
                  BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                    BoxShadow(
                      // 그림자 효과
                      blurRadius: 3,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ]),
              child: Image.network(
                thumb,
                headers: const {
                  'User-Agent':
                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                  'Referer': 'https://comic.naver.com',
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    ); // 현재 보고있는 데이터 표출
  }
}
