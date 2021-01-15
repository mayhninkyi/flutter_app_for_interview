

class Currency{

  String info;

  String description;

  String timestamp;

  Map<String,dynamic> rates;

  Map<String,dynamic> currencies;


  Currency({this.info, this.description, this.timestamp, this.rates,this.currencies});

  Currency.fromJson(Map<String, dynamic> json) {
    info =  json['info'] ;
    description = json['description'];
    timestamp = json['timestamp'];
    rates = json['rates'] ;
    currencies = json['currencies'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info'] = this.info;
    data['description'] = this.description;
    data['timestamp'] = this.timestamp;
    data['rates']=this.rates;
    data['currencies']=this.currencies;
    return data;
  }
}

