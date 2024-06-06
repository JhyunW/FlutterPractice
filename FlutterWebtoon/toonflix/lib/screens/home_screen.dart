import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2,
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.blue.shade100,
        title: const Text(
          "Today's 툰",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<WebtoonModel>>(
        // stateFull을 사용하지 않고도 데이터를 받아오는거에 대한 await처리가 가능
        future: webtoons, // await를 붙여주는 효과
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
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

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      // 안묶을경우 여기부터 시작
      // 자주 사용하는 방식이면 Extract Method를 이용해서 묶을수도 있음
      // ListView.builder는 리스트뷰의 최적화버전 사용자가 보고있는 아이템만 빌드
      scrollDirection: Axis.horizontal, // 스크롤을 가로방향으로 바꾸기
      itemCount: snapshot.data!.length, // 스냅샷의 리스트 길이만큼 보여줌
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        // 빌드되고 있는 아이탬을 보여주는 코드
        var webtoon = snapshot.data![index]; // 현재 보고 있는 인덱스의 데이터를 넣어줌
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      // 콘텐츠 사이사이에 넣어줄거(간격)을 넣어줌
      // 아이탬들 사이에 구분자를 넣어준다고 보면됨
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
