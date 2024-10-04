import 'package:flutter/cupertino.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonDrawerMenu extends StatelessWidget {
  final Widget icon;
  final String? title;
  const CommonDrawerMenu({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Row(
        children: [
          icon,
          kCommonSpaceH10,
          Text(
            title!,
            textAlign: TextAlign.center,
            style: getAppStyle(
              color: CommonColors.blackColor,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
