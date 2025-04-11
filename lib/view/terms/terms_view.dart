import 'package:flutter/material.dart';
import 'package:searcharea/core/component_widget.dart';

class TermsView extends StatefulWidget {
  const TermsView({super.key});

  @override
  State<TermsView> createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  bool _Allagreed = false;
  bool _gpsTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("약관동의"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
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
                value: _Allagreed,
                onChanged: (value) {
                  setState(() {
                    _Allagreed = value ?? false;
                    _gpsTerms = _Allagreed;
                  });
                },
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color.fromRGBO(0, 79, 255, 1), // 버튼 배경색,
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
                value: _gpsTerms,
                onChanged: (value) {
                  setState(() {
                    _gpsTerms = value ?? false;
                    _Allagreed = _gpsTerms;
                  });
                },
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color.fromRGBO(0, 79, 255, 1), // 버튼 배경색,
                checkColor: Colors.white,
              ),
            ),
            const Spacer(), 
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed:
                    _gpsTerms
                        ? () {
                         
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // 버튼을 가로로 꽉 채움
                  backgroundColor: Color.fromRGBO(0, 79, 255, 1), // 버튼 배경색
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
        ),
      ),
    );
  }
}


void main() {
  runApp(const MaterialApp(home: TermsView()));
}
