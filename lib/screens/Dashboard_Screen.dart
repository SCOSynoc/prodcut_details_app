
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_details_apps/screens/Favourite_products.dart';
import 'package:product_details_apps/screens/Home_Screen.dart';

import 'package:product_details_apps/screens/Products_Details_Screen.dart';
import 'package:product_details_apps/screens/Profile_Screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.isUserGuest});
  final bool? isUserGuest;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentPageIndex = 0;
  bool userGuest = false;


  List<Widget> tabs = [
    const AllProductsScreen(),
    const ProfileScreen()
  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.production_quantity_limits),
            icon: Icon(Icons.production_quantity_limits_outlined),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.account_circle),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: tabs[currentPageIndex],
    );
  }
}
