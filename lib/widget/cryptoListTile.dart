import 'package:coin_trace/Provider/MarketProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/Cryptocurrency.dart';
import '../Provider/ThemeProvider.dart';
import '../Screen/DetailsScreen.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoCurrency currentCrypto;
  final ThemeProvider themeProvider;
  const CryptoListTile({super.key,required this.currentCrypto,required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    
    MarketProvider marketProvider = Provider.of<MarketProvider>(context,listen: false);
    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(id: currentCrypto.id!)));
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: GestureDetector(
                        onDoubleTap: (){
                                (currentCrypto.isFav==false)? marketProvider.addFav(currentCrypto) : marketProvider.removeFav(currentCrypto);
                        },
                        child: CircleAvatar(backgroundColor: currentCrypto.isFav == true ? Colors.red : Colors.transparent,
                        radius: 21,
                        child: CircleAvatar(
                          radius: 19,
                          backgroundColor:
                              themeProvider.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                          backgroundImage: NetworkImage(currentCrypto.image!,),
                        ),)
                      ),
                      title: Text(
                        currentCrypto.name!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "₹ " +
                                currentCrypto.currentPrice!.toStringAsFixed(4),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Builder(
                            builder: (context) {
                              double priceChange =
                                  currentCrypto.price_change_24h!;
                              double priceChangePercentage =
                                  currentCrypto.price_percentage_change_24h!;

                              if (priceChange < 0) {
                                return Text(
                                  "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                );
                              } else {
                                return Text(
                                  "+ ${priceChangePercentage.toStringAsFixed(2)} % (+ ${priceChange.toStringAsFixed(4)})",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    );
  }
}