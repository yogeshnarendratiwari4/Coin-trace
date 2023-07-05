import 'package:coin_trace/Model/Cryptocurrency.dart';
import 'package:coin_trace/Provider/MarketProvider.dart';
import 'package:coin_trace/widget/cryptoListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Provider/ThemeProvider.dart';

class Favorite extends StatefulWidget {
  
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Consumer<MarketProvider>
    (builder: (context,marketProvider,child){
        List<CryptoCurrency> fav = marketProvider.markets.where((element) => element.isFav==true).toList();
        if(fav.length>0){
          return ListView.builder(
          
          itemCount: fav.length,
          itemBuilder: (context,index){
            CryptoCurrency currentCrypto = fav[index];
            return CryptoListTile(currentCrypto: currentCrypto, themeProvider: themeProvider);
          }
          );
        }
        else{
           return const Center(child: Text("No favourites yet"),);
        }
       

        
    });
  }
}
