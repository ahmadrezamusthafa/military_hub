import 'dart:convert';

import 'package:military_hub/config/api_config.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/models/janus/results/id_result_model.dart';
import 'package:uuid/uuid.dart';

class JanusWebRTCRepository {
  JanusWebRTCRepository();

  Future<IdResultModel> createTransaction() async {
    IdResultModel result;
    try {
      var params = {
        "janus": "create",
        "transaction": Uuid().toString(),
      };
      var response = await HttpRequest.getInstance()
          .postWithoutCallBack(API.MSEngineWebRTCUrl, params: params);
      print("$response");
      Map<String, dynamic> data = jsonDecode(jsonEncode(response));
      result = IdResultModel.fromJson(data['data']);
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return result;
  }

  Future<IdResultModel> attachPlugin(String sessionId, String plugin) async {
    IdResultModel result;
    try {
      var params = {
        "janus": "attach",
        "plugin": plugin,
        "transaction": Uuid().toString(),
      };
      var response = await HttpRequest.getInstance().postWithoutCallBack(
          API.MSEngineWebRTCUrl + "/" + sessionId,
          params: params);
      print("$response");
      Map<String, dynamic> data = jsonDecode(jsonEncode(response));
      result = IdResultModel.fromJson(data['data']);
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return result;
  }
}
