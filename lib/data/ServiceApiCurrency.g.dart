// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServiceApiCurrency.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ServiceApiCurrency implements ServiceApiCurrency {
  _ServiceApiCurrency(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://forex.cbm.gov.mm/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Currency> getCurrencyRate() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('api/latest',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Currency.fromJson(_result.data);
    return value;
  }

  @override
  Future<Currency> getCurrencyName() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('api/currencies',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Currency.fromJson(_result.data);
    return value;
  }
}
