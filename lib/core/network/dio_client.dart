import 'package:dio/dio.dart';
import '../constants/api_endpoints.dart';
import '../error/exceptions.dart';

class DioClient {
  final Dio _dio;

  DioClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiEndpoints.baseUrl,
                connectTimeout: ApiEndpoints.connectTimeout,
                receiveTimeout: ApiEndpoints.receiveTimeout,
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  ServerException _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    String message;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Waktu koneksi habis. Silakan coba kembali.';
        break;
      case DioExceptionType.badResponse:
        final responseData = error.response?.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message')) {
          message = responseData['message'].toString();
        } else {
          message = 'Terjadi kesalahan pada server (Kode: $statusCode)';
        }
        break;
      case DioExceptionType.connectionError:
        message = 'Tidak dapat terhubung ke server. Periksa jaringan Anda.';
        break;
      case DioExceptionType.cancel:
        message = 'Permintaan dibatalkan.';
        break;
      default:
        message = 'Terjadi kesalahan jaringan yang tidak terduga.';
    }

    return ServerException(message: message, statusCode: statusCode);
  }
}
