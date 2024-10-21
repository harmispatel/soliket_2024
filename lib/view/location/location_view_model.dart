import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:solikat_2024/models/confirm_location_master.dart';

import '../../database/app_preferences.dart';
import '../../services/api_para.dart';
import '../../services/index.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/global_variables.dart';
import '../common_view/bottom_navbar/bottom_navbar_view.dart';
import '../home/home_view.dart';

class LocationViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> confirmLocationApi({
    required String latitude,
    required String longitude,
    required String location,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.latitude: latitude,
      ApiParams.longitude: longitude,
    };
    ConfirmLocationMaster? master =
        await _services.api!.confirmLocation(params: params);
    print("..................$master");
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (!master.status! &&
        master.message ==
            "SOLIKET is not available at this location, We will be soon there.") {
      AppPreferences.instance.setUserLocation(location);
      AppPreferences.instance.setUserLat(latitude);
      AppPreferences.instance.setUserLong(longitude);
      gUserLocation = await AppPreferences.instance.getUserLocation();
      pushAndRemoveUntil(HomeView());
    } else if (!master.status!) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.status!) {
      log("Success :: true");
      AppPreferences.instance.setUserLocation(location);
      AppPreferences.instance.setUserLat(latitude);
      AppPreferences.instance.setUserLong(longitude);
      gUserLocation = await AppPreferences.instance.getUserLocation();
      pushAndRemoveUntil(BottomNavBarView());
    }
    notifyListeners();
  }
}
