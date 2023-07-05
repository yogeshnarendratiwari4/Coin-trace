
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Provider/ThemeProvider.dart';
import 'Favorite.dart';
import 'Market.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  Future<void> DialogBox() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('About us'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text1),
              Text(text2),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coin Trace",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeProvider.themeMode == ThemeMode.light
                  ? Colors.black87
                  : Colors.white70),
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.light
            ? Colors.blueGrey
            : Colors.black38,
        actions: [
          IconButton(
              onPressed: () {
                DialogBox();
              
              },
              icon: Icon(
                Icons.account_circle,
                color: themeProvider.themeMode == ThemeMode.light
                    ? Colors.black45
                    : Colors.white70,
              )),
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: themeProvider.themeMode == ThemeMode.light
                ? Icon(
                    FontAwesomeIcons.sun,
                    color: Colors.black45,
                    size: 22,
                  )
                : Icon(
                    FontAwesomeIcons.moon,
                    color: Colors.white70,
                  ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(
          top: 0,
          left: 20,
          right: 20,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
            
                controller: _tabController,
                indicatorColor: Colors.blueGrey,
                tabs:  [
            
              Tab(
               child: Text("Trace",style: TextStyle(color: themeProvider.themeMode == ThemeMode.light
                   ? Colors.black
                   : Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
              ),
              Tab(
                child: Text("Favourite",style: TextStyle(color: themeProvider.themeMode == ThemeMode.light
                    ? Colors.black
                    : Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
              ),
            
            
            ]),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                controller: _tabController,
                  children: [
                    Market(),
                    Favorite(),

                  ]
              ),
            )
          ],
        ),
      )),
    );
  }
}

const String text1 = 'This app is created by Yogesh Tiwari, an engineering student of electrical engineering at NIT Jamshedpur in his 3rd year.\n';
const String text2 = 'This app is all about to get the track of crypto currency with market capitalization and ranking, price alerts about tokens and coins.From Bitcoin to altcoins, get accurate and real-time rates in one place and can choose your favorite coins';
