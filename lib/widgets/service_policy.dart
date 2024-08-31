import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ServicePolicy extends StatefulWidget {
  const ServicePolicy({super.key});

  @override
  State<StatefulWidget> createState() => _ServicePolicy();
}

class _ServicePolicy extends State<ServicePolicy> {
  late WebViewController controller;

  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://54.180.145.199:8080/service_terms.html'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
