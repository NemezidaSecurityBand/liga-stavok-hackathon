// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://jsonplaceholder.typicode.com';
  }

  final Dio _dio;

  String baseUrl;
}
