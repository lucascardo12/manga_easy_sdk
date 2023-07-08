class BannerModel {
  String? id;
  final String type;
  final String image;
  final String link;
  final int createdat;
  final int updatedat;

  BannerModel({
    this.id,
    required this.image,
    required this.link,
    required this.type,
    required this.createdat,
    required this.updatedat,
  });

  factory BannerModel.empty() {
    return BannerModel(
      image: '',
      link: '',
      type: '',
      createdat: 0,
      updatedat: 0,
    );
  }

  BannerModel copyWith({
    String? id,
    String? type,
    String? image,
    String? link,
    int? createdat,
    int? updatedat,
  }) {
    return BannerModel(
      id: id ?? this.id,
      type: type ?? this.type,
      image: image ?? this.image,
      link: link ?? this.link,
      createdat: createdat ?? this.createdat,
      updatedat: updatedat ?? this.updatedat,
    );
  }
}
