import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/utils/local_images.dart';

import '../../widget/primary_button.dart';
import '../location/location_allow_view.dart';
import 'home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CommonAppBar(
        //   title: 'Home',
        //   isTitleBold: false,
        //   iconTheme: IconThemeData(color: CommonCo
        //   lors.blackColor),
        // ),
        body: Padding(
          padding: kCommonScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service Unavailable!",
                          style: getAppStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              height: 1.2),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Joshupura, junagadh, gujarat, Joshupura",
                                maxLines: 1,
                                style: getAppStyle(
                                    fontSize: 15,
                                    height: 1.2,
                                    color: CommonColors.black54),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,
                                color: CommonColors.black54),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: CommonColors.mGrey200),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person_2_outlined,
                        color: CommonColors.black54,
                        size: 22,
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Center(
                child: Image.asset(
                  LocalImages.img_location_disable,
                  height: 200,
                ),
              ),
              Text(
                "Service Unavailable!",
                style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              kCommonSpaceV10,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  "Soliket is not available at this location, We will be soon there",
                  style: getAppStyle(
                      fontSize: 20, height: 1.2, color: CommonColors.black54),
                ),
              ),
              kCommonSpaceV30,
              PrimaryButton(
                height: 55,
                width: kDeviceWidth / 1.5,
                lblSize: 18,
                label: "Try Different Location",
                onPress: () {
                  push(LocationAllowView());
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  push(Home());
                },
                child: Text(
                  "See Home Screen",
                  style: getAppStyle(fontSize: 20, color: Colors.blueAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
