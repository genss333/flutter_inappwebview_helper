import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'model.dart';

abstract interface class WebviewRepositoryInterface {
  Future<void> get({required WebviewGETModel model});

  Future<void> post({required WebviewPOSTModel model});
}

class WebviewRepository implements WebviewRepositoryInterface {
  @override
  Future<void> get({required WebviewGETModel model}) async {
    debugPrint('URL: ${model.url}');

    model.getLoadingCallback!.call();

    await model.webViewController!.loadUrl(
      urlRequest: URLRequest(
        headers: model.headers,
        url: Uri.parse(model.url!),
      ),
    );

    model.webViewController?.addJavaScriptHandler(
      handlerName: model.handlerName!,
      callback: (datacallback) {
        model.getDataCallback?.call(datacallback);
      },
    );
  }

  @override
  Future<void> post({required WebviewPOSTModel model}) async {
    debugPrint('URL: ${model.url}');

    await model.webViewController?.evaluateJavascript(
        source: '${model.funcName}(${jsonEncode(model.json)})');

    model.webViewController?.addJavaScriptHandler(
      handlerName: model.handlerName!,
      callback: (datacallback) async {
        model.getDataCallback?.call(datacallback);
      },
    );
  }
}
