import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String,String> currencyExchangeMap;

//  List<dynamic> cryptoRateList = List(cryptoList.length);

  var btcRate = '?';
//  var ethRate = '?';
//  var ltcRate = '?';

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> items = List();

    for (String currency in currenciesList) {
      DropdownMenuItem<String> dropdownMenuItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      items.add(dropdownMenuItem);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: items,
        onChanged: (value) {
          fetchCoinData(value);
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  CupertinoPicker getCupertinoPicker() {
    List<Widget> items = List();

    for (String currency in currenciesList) {
      Text dropdownMenuItem = Text(currency);
      items.add(dropdownMenuItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        fetchCoinData(currenciesList[selectedIndex]);
      },
      children: items,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return getCupertinoPicker();
    } else if (Platform.isAndroid) {
      return getDropDownButton();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCoinData(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              children: getAllCryptoButtons(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }

  void fetchCoinData(String currency) async {
    CoinData coinData = CoinData();
    Map<String,String> resultMap = await coinData.getCoinData(currency);
    setState(() {
      currencyExchangeMap = resultMap;
    });
//    print(usdRate);
  }

  getAllCryptoButtons() {
    List<Widget> widgetList = List();

    for(int i=0;i<cryptoList.length;i++){

      String exchangeValue;
      if(currencyExchangeMap!=null){
        exchangeValue = currencyExchangeMap[cryptoList[i]]??'?';
      }else{
        exchangeValue = '?';
      }

      Widget widget = Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${cryptoList[i]} = $exchangeValue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

      widgetList.add(widget);
    }

    return widgetList;

  }
}

//class CryptoCardButton extends StatelessWidget {
//  final String cryptoName;
//  final String valueInCurrency;
//
//  CryptoCardButton({@required this.cryptoName, @required this.valueInCurrency});
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//      child: Card(
//        color: Colors.lightBlueAccent,
//        elevation: 5.0,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(10.0),
//        ),
//        child: Padding(
//          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//          child: Text(
//            '1 $cryptoName = $valueInCurrency',
//            textAlign: TextAlign.center,
//            style: TextStyle(
//              fontSize: 20.0,
//              color: Colors.white,
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
