import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? isTitleBold;
  final bool isShowShadow;
  final Color? bgColor;
  final bool? automaticallyImplyLeading;
  final IconThemeData? iconTheme;

  const CommonAppBar({
    this.leading,
    required this.title,
    this.actions,
    this.centerTitle,
    this.isTitleBold = false,
    this.isShowShadow = false,
    this.bgColor,
    this.automaticallyImplyLeading,
    this.iconTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? CommonColors.mWhite,
        boxShadow: isShowShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 0, // Spread radius
                  blurRadius: 2, // Blur radius
                  offset: Offset(0, 1), // Changes position of shadow
                ),
              ]
            : [],
      ),
      child: AppBar(
        backgroundColor:
            Colors.transparent, // Set transparent background for the AppBar
        elevation: 0,
        iconTheme: iconTheme,
        leading: leading,
        centerTitle: centerTitle ?? true,
        automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        title: Text(
          title!,
          style: isTitleBold!
              ? getAppStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )
              : getAppStyle(
                  fontSize: 18,
                  fontWeight:
                      Theme.of(context).appBarTheme.titleTextStyle!.fontWeight,
                  color: Colors.black87,
                ),
        ),
        actions: actions ?? [],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
