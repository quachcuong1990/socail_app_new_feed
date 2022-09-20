

import '../providers/api_provider.dart';

abstract class DeleteRepo {
  final _apiProvider = ApiProvider();

  String get url;

  Future<bool> delete({String? id}) async {
    final realURL = id == null ? url : url.replaceFirst(':id', id);
    final res = await _apiProvider.delete(realURL);
    return res.statusCode == 200;
  }
}
