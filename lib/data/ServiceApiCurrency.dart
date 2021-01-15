import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import 'Currency.dart';

part 'ServiceApiCurrency.g.dart';

@RestApi(baseUrl: 'https://forex.cbm.gov.mm/')

abstract class ServiceApiCurrency {
  factory ServiceApiCurrency(Dio dio, {String baseUrl}) = _ServiceApiCurrency;

  static ServiceApiCurrency create() {
    final dio = addInterceptors(Dio());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        responseHeader: false,
        requestBody: false,
        responseBody: false));
    return ServiceApiCurrency(dio);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) => requestInterceptor(options),
          onResponse: (Response response) => responseInterceptor(response),
          onError: (DioError dioError) => errorInterceptor(dioError)));
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    options.connectTimeout = Duration.millisecondsPerMinute * 15;
    options.receiveTimeout = Duration.millisecondsPerMinute * 15;

    return options;
  }

  static dynamic responseInterceptor(Response options) async {
    return options;
  }

  static dynamic errorInterceptor(DioError dioError) {
    return dioError;
  }

 
  //get currency rate
  @GET("api/latest")
  Future<Currency> getCurrencyRate();


  //get currency name
  @GET("api/currencies")
  Future<Currency> getCurrencyName();


}
