## Place Search App
  
``` Place Search App은 네이버 지역 검색 API를 활용하여 사용자가 원하는 장소를 검색하고, 현재 위치를 기반으로 거리순으로 정렬하여 결과를 표시하는 Flutter 기반 모바일 앱입니다. 검색된 장소를 리스트 형태로 보여주며, 각 장소를 클릭하면 상세 정보를 웹뷰로 확인할 수 있습니다.
📋 프로젝트 개요
이 앱은 사용자가 입력한 검색어로 네이버 지역 검색 API를 통해 장소를 검색하고, geolocator를 사용하여 현재 위치와의 거리를 계산해 거리순으로 정렬합니다. MVVM 아키텍처를 기반으로 설계되었으며, provider를 사용해 상태 관리를 구현했습니다. 주요 기능으로는 검색바, 정렬 드롭다운, 리스트뷰, 웹뷰 연동이 포함되어 있습니다.

```


## ✨ 주요 기능

장소 검색: 네이버 지역 검색 API를 통해 사용자가 입력한 키워드로 장소를 검색.
거리 기반 정렬: geolocator를 사용해 현재 위치와의 거리를 계산하여 장소 목록을 정렬.
리스트뷰: 검색된 장소를 카드 형태로 표시하며, 각 카드에는 장소명, 카테고리, 거리, 태그 등이 포함.
웹뷰 연동: 리스트 아이템 클릭 시 네이버 상세 페이지로 이동.
찜 기능: 각 장소를 찜(즐겨찾기)으로 추가/제거 가능.



## 권한 설정

Android:
위치 권한 추가: android/app/src/main/AndroidManifest.xml<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />


## 피그마 시안 
 https://www.figma.com/proto/h22bdfzeJS72DjYKMrXBP6/Untitled?node-id=0-1&t=zzsAsQdHJiRIjJRD-1



5. 앱 실행
Flutter 앱을 실행합니다.
flutter run



##  📱 사용 방법

검색: 상단 검색바에 원하는 장소(예: "맘스터치")를 입력하고 엔터를 누릅니다.
정렬: "가까운 순" 드롭다운을 통해 현재 위치 기준으로 장소를 정렬합니다.
찜 추가: 각 장소 카드의 하트 아이콘을 눌러 찜 목록에 추가/제거합니다.
상세 보기: 장소 카드를 클릭하면 네이버 상세 페이지가 웹뷰로 표시됩니다.

🖥 기술 스택

프레임워크: Flutter 3.x, Dart 3.x
상태 관리: Provider
API: 네이버 지역 검색 API
패키지:
http: API 호출
geolocator: 위치 정보
webview_flutter: 웹뷰 표시
proj4dart: 좌표 변환 (KATECH → WGS84)


아키텍처: MVVM

## 🔧 프로젝트 구조
```
📦 
├─ README.md
├─ assets
│  └─ images
│     ├─ ai-generated2png.png
│     ├─ ai-generatedjpg.jpg
│     ├─ apple.jpg
│     ├─ bag.png
│     ├─ bag_set.png
├─ lib
│  ├─ common
│  │  └─ widgets
│  │     ├─ common_button.dart
│  │     └─ dialog_helper.dart
│  ├─ main.dart
│  ├─ model
│  │  ├─ cart_item.dart
│  │  ├─ product.dart
│  │  └─ review.dart
│  ├─ pages
│  │  ├─ cart
│  │  │  ├─ cart_page.dart
│  │  │  └─ widgets
│  │  │     ├─ item_in_cart.dart
│  │  │     └─ payment_summary.dart
│  │  ├─ detail
│  │  │  ├─ detail_page.dart
│  │  │  └─ widgets
│  │  │     ├─ product_detail_controller.dart
│  │  │     └─ product_detail_page.dart
│  │  ├─ list
│  │  │  ├─ list_page.dart
│  │  │  └─ widgets
│  │  │     └─ product_item.dart
│  │  ├─ registration
│  │  │  ├─ registration_page.dart
│  │  │  └─ widgets
│  │  │     ├─ product_image_selector.dart
│  │  │     └─ product_text_field.dart
│  │  └─ review
│  │     ├─ review_modal_controller.dart
│  │     ├─ review_page.dart
│  │     └─ widgets
│  │        ├─ review_detail_page.dart
│  │        └─ review_modal_widgets.dart
│  ├─ theme
│  │  ├─ dark.dart
│  │  └─ light.dart
│  └─ utils
│     └─ format_price.dart
├─ pubspec.lock
├─ pubspec.yaml
```



##⚠️ 트러블슈팅
1. 한글 입력 시 자음과 모음 분리

문제: 검색바에서 한글 입력 시 자음과 모음이 분리되어 표시됨.
해결: Debouncer와 Future.microtask를 사용하여 입력 이벤트를 300ms 지연 처리.


2. KATECH 좌표계와 WGS84 좌표계 불일치

문제: 네이버 API의 mapx, mapy가 KATECH 좌표계로 제공되어 geolocator와의 거리 계산이 잘못됨.
해결: proj4dart 패키지를 사용하여 KATECH 좌표를 WGS84로 변환 후 거리 계산.




##📜 라이선스
이 프로젝트는 MIT 라이선스에 따라 배포됩니다. 자세한 내용은 LICENSE 파일을 참조하세요.
📬 문의
궁금한 점이 있거나 버그를 발견했다면 이슈를 등록해주세요!
