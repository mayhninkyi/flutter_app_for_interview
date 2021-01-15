
import 'package:flutter/cupertino.dart';
import 'package:flutterappforinterview/data/Currency.dart';
import 'package:flutterappforinterview/data/CurrencyRepository.dart';
import 'package:gson/gson.dart';

class CurrencyViewModel with ChangeNotifier{
  final CurrencyRepository _currencyRepository = CurrencyRepository();
  static const String TAG = "CurrencyViewModel";

  Currency _currencyResult,_currencyNameResult;
  bool _loading = false;


 void callCurrencyRate() async{
   _loading = true;
   notifyListeners();
    debugPrint('call api....');
    _currencyResult= await _currencyRepository.callCurrencyRate();
    debugPrint(TAG + ' notifyListener' + gsonEncode(_currencyResult));
   _loading = false;
   notifyListeners();
  }

  void callCurrencyName() async{
    _loading = true;
    notifyListeners();
    _currencyNameResult= await _currencyRepository.callCurrencyName();
    debugPrint(TAG + ' notifyListener' + gsonEncode(_currencyResult));
    _loading = false;
    notifyListeners();
  }

  Currency get getCurrency{
    return _currencyResult;
  }

  Currency get getCurrencyName{
    return _currencyNameResult;
  }

  get loading{
   return _loading;
  }

}