import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../../utils/common_colors.dart';
import '../../../widget/primary_button.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // if (didPop) {
        //   mViewModel.onMenuTapped(0);
        // }
        if (mViewModel.selectedIndex == 0) {
          return await AwesomeDialog(
            bodyHeaderDistance: 20,
            context: context,
            dialogType: DialogType.info,
            width: MediaQuery.of(context).size.width * 0.90,
            buttonsBorderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            descTextStyle: getAppStyle(fontSize: 15),
            titleTextStyle:
                getAppStyle(fontSize: 18, fontWeight: FontWeight.w500),
            title: 'Close App',
            desc: 'Are you sure you want to close the app?',
            btnOk: PrimaryButton(
              label: "Yes",
              buttonColor: CommonColors.primaryColor,
              labelColor: Colors.white,
              borderRadius: BorderRadius.circular(8),
              onPress: () {
                Navigator.of(context).pop(true);
                SystemNavigator.pop();
              },
            ),
            btnCancel: PrimaryButton(
              label: "No",
              buttonColor: CommonColors.mRed,
              labelColor: Colors.white,
              borderRadius: BorderRadius.circular(8),
              onPress: () {
                Navigator.of(context).pop(false);
              },
            ),
          ).show();
        } else {
          mViewModel.onMenuTapped(0);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
