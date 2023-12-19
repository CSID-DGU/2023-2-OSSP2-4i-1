import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:yakmoya/common/view/default_layout.dart';


class InfoWebView extends StatefulWidget {
  @override
  _GoogleFormWebViewState createState() => _GoogleFormWebViewState();
}

const homeUrl =
    'https://www.health.kr/searchIdentity/search.asp';

class _GoogleFormWebViewState extends State<InfoWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
          },
          onPageStarted: (String url) {
            print(url);
          },
          onPageFinished: (String url) {
            print(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.toString()}');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(homeUrl.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '약학정보원 화면',
        child: WebViewWidget(
      controller: controller,
    ));
  }
}
