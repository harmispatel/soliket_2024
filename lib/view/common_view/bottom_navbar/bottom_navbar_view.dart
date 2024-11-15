import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_colors.dart';
import '../../cart/cart_view.dart';
import '../../category/category_view.dart';
import '../../home/home_view.dart';
import '../../my_orders/my_orders_view.dart';
import '../../profile/profile_view.dart';
import 'bottom_navbar_view_model.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});
  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  late BottomNavbarViewModel mViewModel;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    CategoryView(),
    MyOrdersView(),
    MyCartView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    mViewModel = Provider.of<BottomNavbarViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<BottomNavbarViewModel>(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(mViewModel.selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: CommonColors.mWhite,
          highlightColor: CommonColors.mWhite,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          backgroundColor: CommonColors.mWhite,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
          currentIndex: mViewModel.selectedIndex,
          selectedItemColor: CommonColors.primaryColor,
          unselectedItemColor: CommonColors.black54,
          showUnselectedLabels: true,
          onTap: mViewModel.onMenuTapped,
        ),
      ),
    );
  }
}
