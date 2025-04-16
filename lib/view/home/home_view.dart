import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searcharea/viewmodel/terms/home/homeViewModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create : (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body : SafeArea(
              child: Column(
                children: [
                  const SearchBar(),
                ],
              ),
            )
          );
        },
      ),
    );
  }
}

//커스텀 검색바
class SearchBar extends StatelessWidget{
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context){
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: '찾으시려는 장소를 입력해주세요.',
          prefixIcon: const Icon(Icons.search),
          border : OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color.fromRGBO(242, 248, 252, 1)
        ),
        onChanged: viewModel.updateSearchQuery,
        controller : TextEditingController(text: viewModel.searchQuery)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: viewModel.searchQuery.length),
          ),
      ),
    );
  }
}