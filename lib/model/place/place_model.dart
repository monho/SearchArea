import 'dart:convert';

class Place {
  final String title;
  final String category;
  final String address;
  final String roadAddress;
  final int mapx;
  final int mapy;
  final String link;
  final List<String> tags;
  bool isFavorite;
  double distance;

  Place({
    required this.title,
    required this.category,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
    required this.link,
    required this.tags,
    this.isFavorite = false,
    this.distance = 0.0,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    List<String> dummyTags = ['1회 주문', '포장 가능'];
    return Place(
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      address: json['address'] ?? '',
      roadAddress: json['roadAddress'] ?? '',
      mapx: int.tryParse(json['mapx']?.toString() ?? '0') ?? 0,
      mapy: int.tryParse(json['mapy']?.toString() ?? '0') ?? 0,
      link: json['link'] ?? 'https://naver.com',
      tags: dummyTags,
      isFavorite: false,
    );
  }
}
