import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/utils/local_images.dart';
import 'package:solikat_2024/view/home/profile/profile_view.dart';
import 'package:solikat_2024/view/location/location_donNot_allow_view.dart';

import '../../utils/global_variables.dart';
import '../../widget/primary_button.dart';

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
                              fontSize: 18,
                              height: 1.2),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                gUserLocation,
                                maxLines: 1,
                                style: getAppStyle(
                                    fontSize: 14,
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
                  GestureDetector(
                    onTap: () {
                      push(ProfileView());
                    },
                    child: Container(
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
                    ),
                  )
                ],
              ),
              Spacer(),
              Center(
                child: Image.asset(
                  LocalImages.img_location_disable,
                  height: 160,
                ),
              ),
              Text(
                "Service Unavailable!",
                style: getAppStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              kCommonSpaceV10,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  "Soliket is not available at this location, We will be soon there",
                  style: getAppStyle(
                      fontSize: 16, height: 1.2, color: CommonColors.black54),
                ),
              ),
              kCommonSpaceV20,
              PrimaryButton(
                height: 50,
                width: kDeviceWidth / 1.5,
                lblSize: 16,
                label: "Try Different Location",
                onPress: () {
                  push(LocationDonNotAllowView());
                },
              ),
              Spacer(),

              // Spacer(),
              // GestureDetector(
              //   onTap: () {
              //     push(Home());
              //   },
              //   child: Text(
              //     "See Home Screen",
              //     style: getAppStyle(fontSize: 20, color: Colors.blueAccent),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
