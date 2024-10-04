import 'package:flutter/cupertino.dart';

import '../utils/common_colors.dart';

class CommonSocialMediaContainer extends StatelessWidget {
  final String image;

  const CommonSocialMediaContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 70,
      decoration: BoxDecoration(
        color: CommonColors.mGrey300,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(image),
      ),
    );
  }
}
