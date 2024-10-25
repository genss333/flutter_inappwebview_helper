import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  final Function(InAppWebViewController xcontroller) callback;
  final Function(String error) callbackError;

  const WebViewPage({
    super.key,
    required this.callback,
    required this.callbackError,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  Timer? _timeoutTimer;
  static const _timeoutDuration = Duration(seconds: 30);

  void _startTimeout(InAppWebViewController controller) {
    debugPrint("startTimeOut");
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(_timeoutDuration, () {
      widget.callbackError("Request timed out");
      controller.stopLoading();
    });
  }

  void _cancelTimeout() {
    debugPrint("cancelTimeout");
    _timeoutTimer?.cancel();
  }

  @override
  void dispose() {
    _cancelTimeout();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      key: const ValueKey('webview'),
      androidOnPermissionRequest: (webviewController, origin, resources) {
        return AppWebViewOption.andriodPerMission(
          webviewController,
          origin,
          resources,
        );
      },
      initialOptions: AppWebViewOption.groupOption,
      onWebViewCreated: (webviewController) async {
        widget.callback(webviewController);
        _startTimeout(webviewController);
      },
      onProgressChanged: (xcontroller, progresse) {
        debugPrint("${(progresse / 100) * 100}%");
        if (progresse == 100) {
          _cancelTimeout();
        }
      },
      onLoadHttpError: (xcontroller, url, statusCode, description) {
        _cancelTimeout();
        widget.callbackError("code: $statusCode, message: $description");
      },
    );
  }
}

class AppWebViewOption {
  static final groupOption = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      useOnDownloadStart: true,
      userAgent:
          "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15A5341f Safari/604.1",
    ),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
  );

  static Future<PermissionRequestResponse?> andriodPerMission(
    InAppWebViewController controller,
    String origin,
    List<String> resources,
  ) async {
    return PermissionRequestResponse(
      resources: resources,
      action: PermissionRequestResponseAction.GRANT,
    );
  }
}
