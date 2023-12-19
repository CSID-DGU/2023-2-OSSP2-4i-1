# 💊이 약 무슨 약? 약모야

# 🤔 This Repo?
### 알약 이미지 인식 어플리케이션, 약모야(Yakmoya) Front Flutter Repository

# ✅ Dependencies
```dart
dependencies:
  flutter_screenutil: ^5.8.4
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  image_picker: ^1.0.4
  tflite: ^1.1.2
  provider: ^6.0.5
  dio: ^5.2.1+1
  flutter_secure_storage: ^8.0.0
  json_annotation: ^4.8.1
  retrofit: '>=4.0.0 <5.0.0'
  logger: any  #for logging purpose
  flutter_riverpod: ^2.3.6
  riverpod_annotation: ^2.1.1
  skeletons: ^0.0.3
  go_router: ^10.0.0
  badges: ^3.1.1
  uuid: ^3.0.7
  debounce_throttle: ^2.0.0
  flutter_local_notifications: ^15.1.0+1
  flutter_localization: ^0.1.13
  permission_handler: ^10.4.3
  http: ^1.1.0
  flutter_svg: ^2.0.9
  dio_cookie_manager: ^3.1.1
  cookie_jar: ^4.0.8
  firebase_core: ^2.23.0
  flutter_launcher_icons: ^0.9.3
  firebase_messaging: ^14.5.0
  google_mlkit_text_recognition: ^0.5.0
  iamport_flutter: ^0.10.13
  url_launcher: ^6.1.12
  webview_flutter: ^4.4.2
  app_settings: ^5.1.1
  image: ^3.0.1
  introduction_screen: ^3.1.12
  camera: ^0.9.4+5



dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  build_runner: ^2.4.6
  json_serializable: ^6.6.0
  retrofit_generator: '>=5.0.0 <6.0.0'
  riverpod_generator: ^2.2.3



flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/img/heartlogo.png"

```

# 🛠️ How To Build

## 1️⃣ 실행
```dart
flutter run // 플러터 실행
을 통해서 실행해주자
```

## 2️⃣ 실행이 안될때

1. flutter ERROR
```dart
flutter clean // 플러터 의존성 제거
flutter pub get  // 의존성 패키지 재설치
을 통해서 플러터 의존성을 다시 받아주자.
```

2. iOS ERROR
```dart
cd ios // ios 폴더 이동
rm -rf Podfile.lock // Podfile.lock 제거
pod install --repo-update // 의존성 패키지 재설치
```
