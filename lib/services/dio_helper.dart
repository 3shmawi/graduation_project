import 'package:dio/dio.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app/api.dart';
import '../presentation/_resources/component/toast.dart';

class HttpUtil {
  late Dio _dio;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      // connectTimeout: const Duration(seconds: 15),
      // receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    );
    _dio = Dio(options);
    _dio.interceptors
        .add(PrettyDioLogger(requestHeader: true, requestBody: true));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          var accessToken = AuthCtrl.usrToken ?? "";
          if (accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      if (e is DioException) {
        ErrorEntity eInfo = createErrorEntity(e);

        onError(eInfo);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      if (e is DioException) {
        ErrorEntity eInfo = createErrorEntity(e);

        onError(eInfo);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      if (e is DioException) {
        ErrorEntity eInfo = createErrorEntity(e);

        onError(eInfo);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      if (e is DioException) {
        ErrorEntity eInfo = createErrorEntity(e);

        onError(eInfo);
      }
      rethrow;
    }
  }

  Future<dynamic> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      if (e is DioException) {
        ErrorEntity eInfo = createErrorEntity(e);

        onError(eInfo);
      }
      rethrow;
    }
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";

    return "Exception code $code, $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timed out");

    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timed out");

    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timed out");

    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad SSL certificates");

    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: "Bad request");
        case 401:
          return ErrorEntity(code: 401, message: "Permission denied");
        case 500:
          return ErrorEntity(code: 500, message: "Server internal error");
      }
      return ErrorEntity(
          code: error.response!.statusCode!, message: "Server bad response");

    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server canceled it");

    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");

    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity eInfo) {
  if (kDebugMode) {
    debugPrint(
        'error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
  }
  switch (eInfo.code) {
    case 400:
      if (kDebugMode) {
        ShowToast.error("Bad Request");
      }
      break;
    case 401:
      if (kDebugMode) {
        ShowToast.error("Unauthorized");
      }
      break;
    case 403:
      if (kDebugMode) {
        ShowToast.error("Forbidden");
      }
      break;
    case 404:
      if (kDebugMode) {
        ShowToast.error("Not Found");
      }
      break;
    case 405:
      if (kDebugMode) {
        ShowToast.error("Method Not Allowed");
      }
      break;
    case 408:
      if (kDebugMode) {
        ShowToast.error("Request Timeout");
      }
      break;
    case 409:
      if (kDebugMode) {
        ShowToast.error("Conflict");
      }
      break;
    case 410:
      if (kDebugMode) {
        ShowToast.error("Gone");
      }
      break;
    case 500:
      if (kDebugMode) {
        ShowToast.error("Internal Server Error");
      }
      break;
    case 501:
      if (kDebugMode) {
        ShowToast.error("Not Implemented");
      }
      break;
    case 502:
      if (kDebugMode) {
        ShowToast.error("Bad Gateway");
      }
      break;
    case 503:
      if (kDebugMode) {
        ShowToast.error("Service Unavailable");
      }
      break;
    case 504:
      if (kDebugMode) {
        ShowToast.error("Gateway Timeout");
      }
      break;
    case 505:
      if (kDebugMode) {
        ShowToast.error("HTTP Version Not Supported");
      }
      break;
    default:
      if (kDebugMode) {
        ShowToast.error("Unknown Error");
      }
      break;
  }
}
