import 'package:flutter/material.dart';

class CustomPlaceItem extends StatelessWidget {
  final Map<String, dynamic> place;
  final VoidCallback onFavoriteToggle;

  const CustomPlaceItem({
    super.key,
    required this.place,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFFFFFF), // 배경색 #F5F7F9
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 (Placeholder)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Icon(Icons.camera_alt, size: 40)),
            ),
            const SizedBox(width: 12),
            // 텍스트 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 이름과 하트 아이콘
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        place['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          place['isFavorite']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: place['isFavorite'] ? Colors.red : Colors.grey,
                        ),
                        onPressed: onFavoriteToggle,
                      ),
                    ],
                  ),
                  // 거리와 리뷰 수
                  Text(
                    '${place['distance']}km ${place['reviewCount']}분',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // 카테고리
                  Text(
                    place['category'],
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  // 태그
                  Wrap(
                    spacing: 8,
                    children:
                        (place['tags'] as List<String>).map((tag) {
                          return Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                            backgroundColor: const Color(
                              0xFFE6F0FA,
                            ), // 태그 배경색 #E6F0FA
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xFFE6F0FA), // 테두리 색상 #E6F0FA
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
