class WebtoonModel {
  final String title, thumb, id;

  // named constructor, break up the data
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
