import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searcharea/viewmodel/terms/home/homeViewModel.dart';
import 'package:searcharea/view/home/widget/placeListView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> places = [
    {
      'name': '모모야마',
      'distance': 0.7,
      'reviewCount': 29,
      'category': '식당',
      'tags': ['1회 주문', '포장 가능'],
      'isFavorite': false,
    },
    {
      'name': '즐겨운 순삭',
      'distance': 0.7,
      'reviewCount': 29,
      'category': '식당',
      'tags': ['1회 주문', '포장 가능'],
      'isFavorite': false,
    },
    {
      'name': '즐겨운 순삭',
      'distance': 0.7,
      'reviewCount': 29,
      'category': '식당',
      'tags': ['1회 주문', '포장 가능'],
      'isFavorite': false,
    },
    {
      'name': '즐겨운 순삭',
      'distance': 0.7,
      'reviewCount': 29,
      'category': '식당',
      'tags': ['1회 주문', '포장 가능'],
      'isFavorite': false,
    },
    {
      'name': '즐겨운 순삭',
      'distance': 0.7,
      'reviewCount': 29,
      'category': '식당',
      'tags': ['1회 주문', '포장 가능'],
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  children: [
                    const CustomSearchBar(),
                    SizedBox(height: 15),
                    const CustomSortDropdown(),
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          return CustomPlaceItem(
                            place: places[index],
                            onFavoriteToggle: () {
                              setState(() {
                                places[index]['isFavorite'] =
                                    !places[index]['isFavorite'];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//커스텀 검색바
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    return TextField(
      decoration: InputDecoration(
        hintText: '찾으시려는 장소를 입력해주세요.',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color.fromRGBO(242, 248, 252, 1),
      ),
      onChanged: viewModel.updateSearchQuery,
      controller: TextEditingController(text: viewModel.searchQuery)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: viewModel.searchQuery.length),
        ),
    );
  }
}

class CustomSortDropdown extends StatelessWidget {
  const CustomSortDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE8EEF2), // #E8EEF2 색상
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0), // 둥글기 적용
              ),
              child: DropdownButton<String>(
                value: viewModel.sortOption,
                items:
                    ['가까운 순'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: viewModel.updateSortOption,
                underline: const SizedBox(), // 기본 밑줄 제거
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
