import 'dart:convert' as j;
import '../../helpes.dart';
import '../manga/chapter.dart';
import '../manga/manga.dart';

class Historico {
  String? id;
  String uniqueid;
  Manga manga;
  String idUser;
  @Deprecated("User currentChapter 0.13.0 -> 0.15.0")
  Chapter? capAtual;
  String? currentChapter;
  int updatedAt;
  int createdAt;
  bool isDeleted;
  List<String> chapterLidos;
  bool isSync;

  Historico({
    this.capAtual,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.idUser,
    required this.manga,
    required this.chapterLidos,
    required this.uniqueid,
    required this.isSync,
    this.currentChapter,
  });

  Historico.fromJson(Map<String, dynamic> json)
      : id = json['\$id'] ?? json['id'] ?? json['_uid'],
        uniqueid = Helps.convertUniqueid(json['uniqueid'] ?? json['idManga']),
        capAtual = convertJsonToChapter(json),
        currentChapter =
            json['currentChapter'] ?? convertJsonToChapter(json)?.title,
        idUser = json['idUser'] ?? '',
        updatedAt = validateUpdatedAt(json),
        isDeleted = validateIsDeleted(json),
        chapterLidos = Helps.convertStringToList(json['chapterLidos']),
        manga = validateManga(json),
        isSync = json['isSync'] ?? false,
        createdAt = validateCreatedAt(json);

  Map<String, dynamic> toJson() {
    return {
      '\$id': id,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
      'uniqueid': uniqueid,
      'manga': j.json.encode(manga.toJson()),
      'capAtual': capAtual != null ? j.json.encode(capAtual) : null,
      'createdAt': createdAt,
      'isSync': isSync,
      'chapterLidos': chapterLidos,
      'idUser': idUser,
      'currentChapter': currentChapter,
    };
  }

  bool isChapterLido(String chapter) {
    return chapterLidos.contains(chapter.trim());
  }

  static int validaDatatime(data) {
    if (data == null || data is DateTime) {
      return DateTime.now().millisecondsSinceEpoch;
    }
    return data;
  }

  static Chapter? convertJsonToChapter(Map<String, dynamic> json) {
    return json['capAtual'] != null
        ? Chapter.fromJson(Helps.decode(json['capAtual']))
        : null;
  }

  static int validateUpdatedAt(Map<String, dynamic> json) {
    if (json['updatedAt'] != null) {
      return json['updatedAt'];
    }
    if (json['dataUp'] != null) {
      return json['dataUp'];
    }
    return DateTime.now().millisecondsSinceEpoch;
  }

  static int validateCreatedAt(Map<String, dynamic> json) {
    if (json['createdAt'] != null) {
      return json['createdAt'];
    }
    if (json['dataCria'] != null) {
      var date = json['dataCria'];
      if (date is DateTime) {
        return date.millisecondsSinceEpoch;
      }
      return DateTime.parse(date).millisecondsSinceEpoch;
    }
    return DateTime.now().millisecondsSinceEpoch;
  }

  static Manga validateManga(Map<String, dynamic> json) {
    if (json['manga'] != null) {
      return Manga.fromJson(Helps.decode(json['manga']));
    }
    return Manga(
      capa: '',
      href: '',
      uniqueid: Helps.convertUniqueid(json['idManga']),
      title: json['idManga'],
      idHost: 0,
    );
  }

  static bool validateIsDeleted(Map<String, dynamic> json) {
    if (json['isDeleted'] != null) {
      return json['isDeleted'];
    }
    if (json['deletado'] != null) {
      return json['deletado'];
    }
    return false;
  }
}
