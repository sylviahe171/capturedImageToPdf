import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebViewContainer extends StatefulWidget {
  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final controller = PlatformWebViewController(
    AndroidWebViewControllerCreationParams(),
  )
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
        LoadRequestParams(uri: Uri.parse('https://tally.so/r/3qP8lO')));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("webview container"),
        ),
        body: PlatformWebViewWidget(
          PlatformWebViewWidgetCreationParams(controller: controller),
        ).build(context),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.import_export),
            onPressed: () async {
              controller.runJavaScript(
                  'document.getElementById("dd2bd7d8-4274-42b8-b7b7-6a3bc527ca47").value = "New Value";');
            }));
  }
}
