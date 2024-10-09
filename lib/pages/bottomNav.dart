import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:zwiggy/pages/homePage.dart';
import 'package:zwiggy/pages/order.dart';
import 'package:zwiggy/pages/profile.dart';
import 'package:zwiggy/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int currentTabIndex=0;
  late List<Widget>pages;
  late Widget currentPage;
  late Homepage homepage;
  late Order order;
  late Wallet wallet;
  late Profile profile;


  @override
  @override
  void initState() {
    homepage=Homepage();
    order=Order();
    wallet=Wallet();
    profile=Profile();

    pages=[homepage,order,wallet,profile];
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height:65,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 100),
          onTap: (int index){
            setState(() {
              currentTabIndex=index;
            });

          },
          items:
          [
            Icon(Icons.home_outlined,color: Colors.white,),
            Icon(Icons.shopping_bag_outlined,color: Colors.white),
            Icon(Icons.wallet_outlined,color: Colors.white),
            Icon(Icons.person_outline,color: Colors.white),
          ]
      ),
      body:pages[currentTabIndex]
      ,
    );
  }
}
