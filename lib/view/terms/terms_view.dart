import 'package:flutter/material.dart';
import 'package:searcharea/core/component_widget.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/terms/termsViewModel.dart';


class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TermsViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("약관동의"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<TermsViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TermsHeaderText(text: '고객님의', textAlign: TextAlign.left),
                  const TermsHeaderText(text: '동의가 필요해요', textAlign: TextAlign.left),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(232, 238, 242, 1),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CheckboxListTile(
                      title: const TermsHeaderText(
                        text: '약관 모두 동의하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(23, 25, 26, 1),
                        ),
                      ),
                      value: viewModel.allAgreed,
                      onChanged: viewModel.toggleAllAgreed,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: const Color.fromRGBO(0, 79, 255, 1),
                      checkColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: CheckboxListTile(
                      title: const TermsHeaderText(
                        text: '필수 위치기반 서비스 이용약관',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      value: viewModel.gpsTerms,
                      onChanged: viewModel.toggleGpsTerms,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: const Color.fromRGBO(0, 79, 255, 1),
                      checkColor: Colors.white,
                    ),
                  ),
                  if (viewModel.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      viewModel.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: viewModel.gpsTerms
                          ? () => viewModel.requestLocationPermission(context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color.fromRGBO(0, 79, 255, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const TermsHeaderText(
                        text: '동의',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TermsHeaderText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TermsHeaderText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: textAlign,
    );
  }
}