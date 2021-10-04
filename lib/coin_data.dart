import 'dart:convert';
import 'package:http/http.dart' as http;
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apikey= 'ccabc6c39cc7024ab6b855f7bc3335c3cc9d70bf';
class CoinData {
  String currency="";
  CoinData(this.currency);
  Future getExchangeRate() async {
    Map <String,String> cryptoPrices={};
    String s="https://api.nomics.com/v1/currencies/ticker?key=$apikey&ids=BTC,ETH,LTC&interval=1d,30d&convert=$currency&per-page=100&page=1";
    Uri url =Uri.parse(s);
    http.Response response=await http.get(url);
    if(response.statusCode==200){
      String data=response.body;
      var decodeData=jsonDecode(data);
      for(int j=0;j<cryptoList.length;j++){
        String lastPrice = decodeData[j]['price'];
        double d=double.parse(lastPrice);
        cryptoPrices[cryptoList[j]] = d.toStringAsFixed(0);
      }
    }
    else{
      print(response.statusCode);
    }
    return cryptoPrices;
  }
}
