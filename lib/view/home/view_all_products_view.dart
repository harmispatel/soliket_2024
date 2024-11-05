import 'package:flutter/material.dart';

import '../../utils/common_colors.dart';
import '../../widget/common_appbar.dart';

class ViewAllProductsView extends StatefulWidget {
  const ViewAllProductsView({super.key});

  @override
  State<ViewAllProductsView> createState() => _ViewAllProductsViewState();
}

class _ViewAllProductsViewState extends State<ViewAllProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Sub Category name",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 20),
            child: GestureDetector(
              onTap: () {
                debugPrint("On Tap Search");
              },
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 2,
          mainAxisSpacing: 5,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Center(
              child: Text("Demo........."),
            ),
            // child: ProductContainer(
            //   onIncrement: null,
            //   onDecrement: null,
            // ),
          );
        },
      ),
    );
  }
}
