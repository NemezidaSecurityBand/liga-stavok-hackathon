import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiClient {
  factory ApiClient(Dio dio){
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    return _ApiClient(dio);}
}