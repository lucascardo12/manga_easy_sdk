import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class Chapter {
  String? id;
  String title;
  double number;
  String href;
  String date;
  List<ImageChapter> imagens;

  Chapter({
    required this.title,
    required this.href,
    required this.id,
    required this.imagens,
    required this.number,
    required this.date,
  });

  Chapter.fromJson(dynamic json)
      : id = json['id'],
        title = json['title'],
        date = json['date'] ?? "",
        number = validateNumber(json['number']),
        imagens = json['imagens'] != null
            ? json['imagens']
                .map<ImageChapter>((e) => ImageChapter.fromJson(e))
                .toList()
            : [],
        href = json['href'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = Helps.removeASCII(date);
    data['title'] = Helps.removeASCII(title);
    data['number'] = number;
    data['href'] = href;
    data['imagens'] = imagens.map((v) => v.toJson()).toList();
    return data;
  }

  static double validateNumber(number) {
    if (number is double) {
      return number;
    }
    return double.tryParse(number.toString()) ?? 0.0;
  }
}
