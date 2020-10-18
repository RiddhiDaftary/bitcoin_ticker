import 'package:http/http.dart' as http;
import 'dart:convert';


const String apiKey = 'A2093279-66F1-4264-9DEF-807D422DC0A2';

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

class CoinData {

  Future<Map<String,String>> getCoinData(String currency) async {

    String baseUrl = 'https://rest.coinapi.io/v1/exchangerate';
    String assetIdQuote = '/$currency';

    Map<String, String> currencyExchangeMap = Map();

    for(String cryptoType in cryptoList){

      String assetIdBase = '/$cryptoType';

      http.Response response = await http.get(
          baseUrl+assetIdBase+assetIdQuote,
          headers: {"X-CoinAPI-Key": apiKey}
      );

      if(response.statusCode==200){
        print(response.body);
        dynamic exchangeRate = jsonDecode(response.body)['rate'];
        String currency = jsonDecode(response.body)['asset_id_quote'];

        currencyExchangeMap[cryptoType] = exchangeRate.toStringAsFixed(2)+' '+currency;
      }else{
        print("some issue. Statuscode is ${response.statusCode}");
      }
    }

    return currencyExchangeMap;

  }


}

//"time": "2017-08-09T14:31:18.3150000Z",
//"asset_id_base": "BTC",
//"asset_id_quote": "USD",
//"rate": 3260.3514321215056208129867667
