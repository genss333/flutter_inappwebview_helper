import 'model.dart';
import 'repository.dart';

class WebViewService {
  final WebviewRepository repository;

  WebViewService({required this.repository});

  Future<void> get({required WebviewGETModel model}) async {
    await repository.get(model: model);
  }

  Future<void> post({required WebviewPOSTModel model}) async {
    await repository.post(model: model);
  }
}
