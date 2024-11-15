import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../utils/common_colors.dart';
import '../../widget/common_appbar.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E8),
      appBar: CommonAppBar(
        title: "Category",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: Center(
        child: Text(
          "Category",
          style: getAppStyle(fontSize: 22),
        ),
      ),
    );
  }
}
