import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/utils/local_images.dart';
import 'package:solikat_2024/view/location/location_donNot_allow_view.dart';

import '../../utils/global_variables.dart';
import '../../widget/primary_button.dart';
import '../profile/profile_view.dart';

class SoliketNotAvailableView extends StatefulWidget {
  const SoliketNotAvailableView({super.key});

  @override
  State<SoliketNotAvailableView> createState() =>
      _SoliketNotAvailableViewState();
}

class _SoliketNotAvailableViewState extends State<SoliketNotAvailableView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: CommonColors.grayShade200,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: CommonColors.grayShade200),
    );
    return SafeArea(
      child: Scaffold(
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
                  push(LocationDoNotAllowView());
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
