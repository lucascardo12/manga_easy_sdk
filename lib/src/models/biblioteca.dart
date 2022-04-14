import 'dart:convert' as j;
import '../helpes.dart';
import 'manga.dart';

enum StatusBiblioteca { lendo, dropado, lido, planejo }

class Biblioteca {
  static String get collectionId => '617b5db178fd3';
  String? id;
  int idHost;
  String idManga;
  String idUser;
  bool deletado;
  DateTime dataCria;
  int dataUpdade;
  Manga? manga;
  String status;
  String uniqueid;

  Biblioteca({
    this.id,
    required this.idHost,
    required this.idManga,
    required this.idUser,
    required this.dataCria,
    required this.dataUpdade,
    required this.deletado,
    required this.manga,
    required this.status,
    required this.uniqueid,
  });

  Biblioteca.fromJson(dynamic json)
      : id = json['\$id'] ?? json['id'],
        idHost = json['idHost'],
        idManga = json['idManga'],
        uniqueid = Helps.convertUniqueid(json['idManga']),
        idUser = json['idUser'],
        dataUpdade = json['dataUpdade'] ?? DateTime.now().millisecondsSinceEpoch,
        deletado = json['deletado'] ?? false,
        status = validaStatus(json['status']),
        manga = json['manga'] != null ? Manga.fromJson(Helps.decode(json['manga'])) : null,
        dataCria = json['dataCria'] is DateTime ? json['dataCria'] : DateTime.parse(json['dataCria']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['\$id'] = this.id;
    data['idHost'] = this.idHost;
    data['idManga'] = this.idManga;
    data['idUser'] = this.idUser;
    data['uniqueid'] = uniqueid;
    data['dataUpdade'] = this.dataUpdade;
    data['deletado'] = this.deletado;
    data['dataCria'] = this.dataCria.toString();
    data['status'] = status;
    data['manga'] = manga != null ? j.json.encode(manga) : null;

    return data;
  }

  static validaStatus(String? status) {
    if (status == null) {
      return StatusBiblioteca.lendo.name;
    }
    if (status.isEmpty) {
      return StatusBiblioteca.lendo.name;
    }
    return status;
  }
}
