import 'package:flutter/material.dart';
import 'package:flutterappforinterview/data/CurrencyViewModel.dart';
import 'package:provider/provider.dart';

import 'data/Currency.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final CurrencyViewModel model = CurrencyViewModel();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrencyViewModel>(
      create: (context) => model,
      child: Consumer<CurrencyViewModel>(builder: (context, model, child) {
        return MaterialApp(
          title: 'Currency Changer',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FirstPage(),
        );
      })
    );
  }
}


class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double result=0.0;
  int input;
  String rate;
  Currency currency;

  CurrencyViewModel model= CurrencyViewModel();
  Map<String,dynamic> rates;
  Map<String,dynamic> currencies;

  @override
  void initState() {
    super.initState();
    _fetchDataFromApi();

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrencyViewModel>(
      create: (context) => model,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Money Exchanger'),
          ),
          body:Consumer<CurrencyViewModel>(builder: (context, model, child) {
            if (model.getCurrency != null) {
              currency=model.getCurrency;
              rates=currency.rates;
            }

            return _checkWeekendDay()? Center(
              child:Image.network('https://image.flaticon.com/icons/png/512/42/42439.png',width: 300,height: 300,)
            ):
            ((!model.loading && model.getCurrency !=null) ? ListView.builder
              (
                itemCount: rates.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(rate:rates.values.elementAt(index),currency:rates.keys.elementAt(index))));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Text( rates.keys.elementAt(index)),
                                  model.getCurrencyName!=null? Text(_getCurrencyName(rates.keys.elementAt(index))):SizedBox.shrink(),
                                ],
                              ),
                              Text(rates.values.elementAt(index)+"  MMK"),

                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Divider(color: Colors.grey,),
                      )
                    ],
                  );
                }
            ) : Center(child:SpinKitFadingCircle(color: Colors.green,))
            );
          }
          )
      ),
    );
  }

  void _fetchDataFromApi() {
    model.callCurrencyRate();
    model.callCurrencyName();
  }

  bool _checkWeekendDay(){
    var now = new DateTime.now();
    if(now.weekday==6 || now.weekday==7){
      return true;
    }else{
      return false;
    }
  }

  String _getCurrencyName(String currency) {
    String currencyName="";
    currencies=model.getCurrencyName.currencies;
    if(currencies!=null){
      currencies.forEach((key, value) {
        if(key==currency){
          currencyName=value;
        }
      });
    }
      return currencyName;

  }
}





class MyHomePage extends StatefulWidget {
  final String rate;
  final String currency;

  MyHomePage({Key key, @required this.rate,@required this.currency})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(this.rate,this.currency);
}

class _MyHomePageState extends State<MyHomePage> {
  double result=0.0;
  int input;
  String rate;
  String currency;

  CurrencyViewModel model= CurrencyViewModel();
  final _formKey = GlobalKey<FormState>();


  _MyHomePageState(this.rate,this.currency);

  @override
  void initState() {
    rate=rate.replaceAll(",", "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrencyViewModel>(
      create: (context) => model,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Money Exchanger'),
        ),
        body:Consumer<CurrencyViewModel>(builder: (context, model, child) {

          return  SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [


                Image.asset('assets/money_icon.png',width: 200,height: 200,),


                SizedBox(height: 32),


                Text(result.toStringAsFixed(2)+" Kyats",style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),),


                SizedBox(
                    height:32
                ),

                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Enter amount '
                            ),
                            validator: (value) {
                              if (value.isEmpty || value=='0') {
                                return 'Enter valid number';
                              }
                              return null;
                            },
                            onSaved: (value){
                              input=int.parse(value);
                            },
                          )),

                      Text(currency,style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),

                      SizedBox(width: 16,),

                      FlatButton(
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green,width: 2)
                        ),
                        child: Text('Calculate'),
                        onPressed: (){
                          FocusManager.instance.primaryFocus.unfocus();
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            setState(() {
                              result=input*double.parse(rate);
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
        )
      ),
    );
  }
}
