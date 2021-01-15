
import 'package:flutterappforinterview/data/ServiceApiCurrency.dart';

import 'Currency.dart';

class CurrencyRepository {
  static const String TAG = "CurrencyRepository";
  var client = ServiceApiCurrency.create();


  Future<Currency> callCurrencyRate() async{
    final serverResult = await client.getCurrencyRate();
    return serverResult;
  }

  Future<Currency> callCurrencyName() async{
    final serverResult = await client.getCurrencyName();
    return serverResult;
  }


}


