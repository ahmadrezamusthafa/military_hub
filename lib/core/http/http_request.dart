import 'package:dio/dio.dart';
import 'package:military_hub/helpers/checker.dart';

var _id = 0;

typedef OnData(t);
typedef OnError(String msg, int code);
enum RequestType { GET, POST, PUT }

class HttpRequest {
  static HttpRequest _instance;
  static const int connectTimeOut = 3 * 1000;
  static const int receiveTimeOut = 7 * 1000;
  static const int maxRetryCount = 3;
  Dio _client;

  static HttpRequest getInstance() {
    if (_instance == null) {
      _instance = HttpRequest._internal();
    }
    return _instance;
  }

  HttpRequest._internal() {
    if (_client == null) {
      BaseOptions options = new BaseOptions();
      options.connectTimeout = connectTimeOut;
      options.receiveTimeout = receiveTimeOut;
      _client = new Dio(options);
    }
  }

  Dio get client => _client;

  void get(
    String url,
    OnData callBack, {
    Map<String, String> params,
    OnError errorCallBack,
    CancelToken token,
  }) async {
    this._request(
      url,
      callBack,
      method: RequestType.GET,
      params: params,
      errorCallBack: errorCallBack,
      token: token,
    );
  }

  Future<Map> getWithoutCallBack(
    String url, {
    Map<String, String> params,
    CancelToken token,
  }) async {
    return this._requestWithoutCallBack(
      url,
      method: RequestType.GET,
      params: params,
      token: token,
    );
  }

  void put(
    String url,
    OnData callBack, {
    Map<String, String> params,
    OnError errorCallBack,
    CancelToken token,
  }) async {
    this._request(
      url,
      callBack,
      method: RequestType.PUT,
      params: params,
      errorCallBack: errorCallBack,
      token: token,
    );
  }

  Future<Map> putWithoutCallBack(
    String url, {
    Map<String, String> params,
    CancelToken token,
  }) async {
    return this._requestWithoutCallBack(
      url,
      method: RequestType.PUT,
      params: params,
      token: token,
    );
  }

  void post(
    String url,
    OnData callBack, {
    Map<String, String> params,
    OnError errorCallBack,
    CancelToken token,
  }) async {
    this._request(
      url,
      callBack,
      method: RequestType.POST,
      params: params,
      errorCallBack: errorCallBack,
      token: token,
    );
  }

  Future<Map> postWithoutCallBack(
    String url, {
    Map<String, String> params,
    CancelToken token,
  }) async {
    return this._requestWithoutCallBack(
      url,
      method: RequestType.POST,
      params: params,
      token: token,
    );
  }

  void postUpload(
    String url,
    OnData callBack,
    ProgressCallback progressCallBack, {
    FormData formData,
    OnError errorCallBack,
    CancelToken token,
  }) async {
    this._request(
      url,
      callBack,
      method: RequestType.POST,
      formData: formData,
      errorCallBack: errorCallBack,
      progressCallBack: progressCallBack,
      token: token,
    );
  }

  Future<Map> _requestWithoutCallBack(
    String url, {
    RequestType method,
    Map<String, String> params,
    FormData formData,
    CancelToken token,
  }) async {
    final id = _id++;
    int retryCount = 0;
    while (retryCount < maxRetryCount) {
      int statusCode;
      try {
        Response response;
        if (method == RequestType.GET) {
          if (mapNotEmpty(params)) {
            response = await _client.get(url,
                queryParameters: params, cancelToken: token);
          } else {
            response = await _client.get(url, cancelToken: token);
          }
        } else if (method == RequestType.PUT) {
          if (mapNotEmpty(params) || formData.toString().isNotEmpty) {
            response = await _client.put(
              url,
              data: formData ?? params,
              cancelToken: token,
            );
          } else {
            response = await _client.put(url, cancelToken: token);
          }
        } else {
          if (mapNotEmpty(params) || formData.toString().isNotEmpty) {
            response = await _client.post(
              url,
              data: formData ?? params,
              cancelToken: token,
            );
          } else {
            response = await _client.post(url, cancelToken: token);
          }
        }

        statusCode = response.statusCode;
        if (response != null) {
          print('HTTP_REQUEST_URL::[$id]::$url');
          print('HTTP_REQUEST_BODY::[$id]::${params ?? ' no'}');
          print('HTTP_RESPONSE_BODY::[$id]::${response.data}');
          if (response.data is List) {
            Map data = response.data[0];
            return data;
          } else {
            Map data = response.data;
            return data;
          }
        }

        if (statusCode < 0) {
          String errorMsg = 'Network request error';
          return Future.error(errorMsg);
        }
      } catch (e) {
        print("HTTP_RESPONSE_ERROR::$e URL::$url");
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          if (retryCount < maxRetryCount) {
            retryCount++;
          } else {
            return Future.error(
                'Connection timeout has reached max attempt $maxRetryCount');
          }
        } else {
          return Future.error(e);
        }
      }
    }
    return Future.error('Unhandled exception');
  }

  void _request(
    String url,
    OnData callBack, {
    RequestType method,
    Map<String, String> params,
    FormData formData,
    OnError errorCallBack,
    ProgressCallback progressCallBack,
    CancelToken token,
  }) async {
    final id = _id++;
    int statusCode;
    try {
      Response response;
      if (method == RequestType.GET) {
        if (mapNotEmpty(params)) {
          response = await _client.get(url,
              queryParameters: params, cancelToken: token);
        } else {
          response = await _client.get(url, cancelToken: token);
        }
      } else {
        if (mapNotEmpty(params) || formData.toString().isNotEmpty) {
          response = await _client.post(
            url,
            data: formData ?? params,
            onSendProgress: progressCallBack,
            cancelToken: token,
          );
        } else {
          response = await _client.post(url, cancelToken: token);
        }
      }

      statusCode = response.statusCode;

      if (response != null) {
        if (response.data is List) {
          Map data = response.data[0];
          callBack(data);
        } else {
          Map data = response.data;
          callBack(data);
        }
        print('HTTP_REQUEST_URL::[$id]::$url');
        print('HTTP_REQUEST_BODY::[$id]::${params ?? ' no'}');
        print('HTTP_RESPONSE_BODY::[$id]::${response.data}');
      }

      if (statusCode < 0) {
        _handError(errorCallBack, statusCode);
        return;
      }
    } catch (e) {
      _handError(errorCallBack, statusCode);
    }
  }

  static void _handError(OnError errorCallback, int statusCode) {
    String errorMsg = 'Network request error';
    if (errorCallback != null) {
      errorCallback(errorMsg, statusCode);
    }
    print("HTTP_RESPONSE_ERROR::$errorMsg code:$statusCode");
  }
}
