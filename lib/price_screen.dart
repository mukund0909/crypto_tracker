import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedcurrency='USD';
  Map <String,String> values={};
  DropdownButton<String> androidPicker(){
    List<DropdownMenuItem<String>> itemList=[];
    for(int j=0;j<currenciesList.length;j++){
      if(currenciesList[j]!=null){
        var item=DropdownMenuItem(child: Text(currenciesList[j]),value: currenciesList[j]);
        itemList.add(item);
      }
    }
    return DropdownButton<String>(
      value: selectedcurrency,
      items: itemList,
      onChanged: (value){
        setState(() {
          if(value!=null){
            selectedcurrency=value;
            getCoinData();
          }
        });
      },
    );
  }
  CupertinoPicker iosPicker(){
    List <Text> list=[];
    for(int j=0;j<currenciesList.length;j++){
      list.add(Text(currenciesList[j]));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (item){
       setState(() {
         if(item!=null){
           selectedcurrency=currenciesList[item];
           getCoinData();
         }
       },
       );
      },
      children: list,
    );
  }
  Widget getPicker(){
    if(Platform.isAndroid){
      return androidPicker();
    }
    else{
      return iosPicker();
    }

  }
  @override
  void initState() {
    super.initState();
    getCoinData();
  }
  void getCoinData() async{
    CoinData coin =CoinData(selectedcurrency);
    values.clear();
    var coindata=await coin.getExchangeRate();
    if(coindata!=null){
      setState(() {
        values=coindata;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Crpto Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CrptoCard(coin: 'BTC',
                currency: selectedcurrency,
                value: values['BTC'] ?? '?',
              ),
              CrptoCard(coin: 'ETH',
                currency: selectedcurrency,
                value: values['ETH'] ?? '?',
              ),
              CrptoCard(coin: 'LTC',
                currency: selectedcurrency,
                value: values['LTC'] ?? '?',
              ),
            ],
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
}

class CrptoCard extends StatelessWidget {
  String coin="",currency="",value="";
  CrptoCard({required this.coin,required this.currency,required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $coin = $value $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

