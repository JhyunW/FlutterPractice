class WebtoonModel {
  final String title, thumb, id;

  // {id: 750184, title: 나쁜사람, thumb: https://image-comic.pstatic.net/webtoon/750184/thumbnail/thumbnail_IMAG21_adfbd65f-18fa-4268-81db-ec88ae4aa8b1.jpg}

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
