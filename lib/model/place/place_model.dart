import 'dart:convert';

class Place {
  final String title;
  final String category;
  final String address;
  final String roadAddress;
  final int mapx;
  final int mapy;
  final List<String> tags;
  bool isFavorite;

  Place({
    required this.title,
    required this.category,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
    required this.tags,
    this.isFavorite = false,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    List<String> dummyTags = ['1회 주문', '포장 가능'];
    return Place(
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      address: json['address'] ?? '',
      roadAddress: json['roadAddress'] ?? '',
      mapx: json['mapx'] ?? 0,
      mapy: json['mapy'] ?? 0,
      tags: dummyTags,
      isFavorite: false,
    );
  }
}
