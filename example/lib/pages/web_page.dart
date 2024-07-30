import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:file_picker/file_picker.dart';
import 'home_page.dart';

class WebViewContainer extends StatefulWidget {
  final File pdf;
  const WebViewContainer({Key? key, required this.pdf}) : super(key: key);

  @override
  _WebViewContainerState createState() => _WebViewContainerState(pdf);
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController controller;
  final File pdf;

//issue with file upload: user have to manually touch anywhere of the page, and then auto file upload works
//why???
//document.querySelector('button[aria-label="Register"]').click(); code for automating register
  String autoFillJavaScript = '''
  document.querySelector('.sc-6663af1f-1.gvjUuC').click();

  function changeReactInputValue(inputDom,newText){
	  let lastValue = inputDom.value;
	  inputDom.value = newText;
	  let event = new Event('input', { bubbles: true });
	  event.simulated = true;
	  let tracker = inputDom._valueTracker;
	  if (tracker) {
  	  tracker.setValue(lastValue);
	  }
	  inputDom.dispatchEvent(event);
  }

  var userIdDom = document.getElementById("dd2bd7d8-4274-42b8-b7b7-6a3bc527ca47");
  changeReactInputValue(userIdDom,'username');
''';

  String autoFillTextField = '''
  function changeReactInputValue(inputDom,newText){
	  let lastValue = inputDom.value;
	  inputDom.value = newText;
	  let event = new Event('input', { bubbles: true });
	  event.simulated = true;
	  let tracker = inputDom._valueTracker;
	  if (tracker) {
  	  tracker.setValue(lastValue);
	  }
	  inputDom.dispatchEvent(event);
  }

  var userIdDom = document.getElementById("dd2bd7d8-4274-42b8-b7b7-6a3bc527ca47");
  changeReactInputValue(userIdDom,'username');
  ''';

  String autoFillCheckbox = '''
  function changeReactCheckboxValue(inputDom, newValue) {
    let lastChecked = inputDom.checked;
    inputDom.checked = newValue;
    let event = new Event('change', { bubbles: true });
    event.simulated = true;
    inputDom.dispatchEvent(event);
    if (lastChecked !== newValue) {
        let clickEvent = new MouseEvent('click', { bubbles: true });
        clickEvent.simulated = true;
        inputDom.dispatchEvent(clickEvent);
    }
}

// Example usage
const checkboxElement = document.getElementById('checkbox_4231cd22-4eb1-48d4-b5e2-a5eb63c45b45');
changeReactCheckboxValue(checkboxElement, true);
  ''';

  _WebViewContainerState(this.pdf);

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://tally.so/r/3qP8lO'));
    //run below listener to overide webview's setonshowfileselector
    addFileSelectionListener();
    super.initState();
  }

  void addFileSelectionListener() async {
    if (Platform.isAndroid) {
      //By casting controller.platform to AndroidWebViewController, you are accessing an Android-specific implementation of the webview controller that allows you to perform platform-specific actions or configurations related to the webview on Android devices.
      final androidController = controller.platform as AndroidWebViewController;

      // setOnShowFileSelector: Sets the callback that is invoked when the client should show a file selector.
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  //The FileSelectorParams object is a parameter that is passed automatically by the webview controller when invoking the file selection callback function. It contains information about the file selection event, such as accepted file types, multiple file selection support, etc.
  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    //final result = await FilePicker.platform.pickFiles();
    final file = pdf;

    return [file.uri.toString()];

/*
    if (result != null && result.files.single.path != null) {
      final file = pdf;
      return [file.uri.toString()];
    }
    */
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("webview container"),
        ),
        body: WebViewWidget(controller: controller),
        floatingActionButton: FloatingActionButton(
            child: Text("Autofill"),
            onPressed: () async {
              controller.runJavaScript(autoFillJavaScript);
            }));
  }
}
