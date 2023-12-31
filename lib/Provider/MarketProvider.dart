import 'dart:async';
import 'package:coin_trace/Model/localStorage.dart';
import 'package:flutter/cupertino.dart';
import '../Model/API.dart';
import '../Model/Cryptocurrency.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];
  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();
    List<String> fav = await LocalStorage.fetchFav();
    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      if(fav.contains(newCrypto.id)){
        newCrypto.isFav = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();

  }
  
  CryptoCurrency fetchCryptoById(String id){
    CryptoCurrency crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFav(CryptoCurrency crypto)async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFav = true;
    await LocalStorage.addFav(crypto.id!);
    notifyListeners();
  }

  void removeFav(CryptoCurrency crypto)async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFav = false;
    await LocalStorage.removeFav(crypto.id!);
    notifyListeners();
  }
}
