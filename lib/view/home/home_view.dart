import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searcharea/core/debouncer.dart';
import 'package:searcharea/view/home/widget/placeListView.dart';
import 'package:searcharea/viewmodel/place/placeViewModel.dart';
import 'package:searcharea/viewmodel/terms/home/homeViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // 초기 검색
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
      Provider.of<PlaceViewModel>(
        context,
        listen: false,
      ).fetchPlaces(homeViewModel.searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => PlaceViewModel()),
      ],
      child: Consumer2<HomeViewModel, PlaceViewModel>(
        builder: (context, homeViewModel, placeViewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  children: [
                    CustomSearchBar(
                      onSearch: (query) {
                        placeViewModel.fetchPlaces(query);
                      },
                    ),
                    const SizedBox(height: 15),
                    const CustomSortDropdown(),
                    const SizedBox(height: 15),
                    Expanded(
                      child:
                          placeViewModel.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : placeViewModel.errorMessage.isNotEmpty
                              ? Center(child: Text(placeViewModel.errorMessage))
                              : ListView.builder(
                                itemCount: placeViewModel.places.length,
                                itemBuilder: (context, index) {
                                  return CustomPlaceItem(
                                    place: placeViewModel.places[index],
                                    onFavoriteToggle: () {
                                      placeViewModel.toggleFavorite(index);
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

// 커스텀 검색바
class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({super.key, required this.onSearch});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    _controller.text = viewModel.searchQuery;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: viewModel.searchQuery.length),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: '찾으시려는 장소를 입력해주세요.',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(242, 248, 252, 1),
      ),
      onChanged: (value) {
        // Debouncer를 사용하여 입력 지연 처리
        _debouncer.run(() {
          Future.microtask(() {
            viewModel.updateSearchQuery(value);
          });
        });
      },
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          widget.onSearch(value);
        }
      },
    );
  }
}

// 커스텀 정렬 드롭다운
class CustomSortDropdown extends StatelessWidget {
  const CustomSortDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeViewModel, PlaceViewModel>(
      builder: (context, homeViewModel, placeViewModel, child) {
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE8EEF2), width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton<String>(
                value: homeViewModel.sortOption,
                items:
                    ['가까운 순'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (value) {
                  homeViewModel.updateSortOption(value, placeViewModel);
                },
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
