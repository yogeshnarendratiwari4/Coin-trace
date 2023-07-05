
import 'package:coin_trace/widget/cryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Cryptocurrency.dart';
import '../Provider/MarketProvider.dart';
import '../Provider/ThemeProvider.dart';
import 'DetailsScreen.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (marketProvider.markets.length > 0) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    CryptoCurrency currentCrypto =
                        marketProvider.markets[index];
                    return CryptoListTile(currentCrypto: currentCrypto, themeProvider: themeProvider) ;
                  }),
            );
          } else {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Center(
                    child: Text(
                  "Data not found",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )));
          }
        }
      },
    );
  }
}
