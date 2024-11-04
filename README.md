# Flutter InAppWebView Helper

A Flutter package that provides helper functions and classes for working with InAppWebView. for esier get data from webview.

## Installation

Add the following line to your `pubspec.yaml` file:

## flutter_inappwebview doc 
 - https://pub.dev/packages/flutter_inappwebview

## Example

class UserService extends GetxService {
  final WebViewService service;

  UserService({required this.service});

  Future<void> fetchData(UserController controller) async {
    await service.get(
      model: WebviewGETModel(
      //webViewController: controller.webViewController,
        url: '',
        handlerName: '',
        getDataCallback: (dataaCallback){},
        getLoadingCallback: (){},
      ),
    );
  }

  Future<void> someAction(UserController controller) async {
     List<Map<String, dynamic>> json = [{}];

     final model = WebviewPOSTModel(
      webViewController: controller.webViewController,
      funcName: "btn_01",
      handlerName: 'ProcessInsert',
      json: json,
      getDataCallback: (dataCallback) {},
    );

    await service.post(model: model);
  }
}

class WebView extends StatelessWidget {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: Stack(
        children: [
          WebViewPage(
            callback: (xcontroller) {},
            callbackError: (error) {},
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
