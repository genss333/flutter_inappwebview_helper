import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewGETModel {
  final String? url;
  final InAppWebViewController? webViewController;
  final VoidCallback? getLoadingCallback;
  final Function(List<dynamic> data)? getDataCallback;
  final String? handlerName;

  WebviewGETModel({
    this.url,
    this.webViewController,
    this.getLoadingCallback,
    this.getDataCallback,
    this.handlerName,
  });
}

class WebviewPOSTModel {
  final String? url;
  final InAppWebViewController? webViewController;
  final Function(List<dynamic> data)? getDataCallback;
  final String? funcName;
  final String? handlerName;
  final List? json;

  WebviewPOSTModel({
    this.url,
    this.webViewController,
    this.getDataCallback,
    this.funcName,
    this.handlerName,
    this.json,
  });
}
