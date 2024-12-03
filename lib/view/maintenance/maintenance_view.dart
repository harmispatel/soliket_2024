import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/remote_config/model/app_down_model.dart';
import '../../utils/common_colors.dart';
import '../../utils/constant.dart';

class MaintenanceView extends StatelessWidget {
  final AppDownMaster? appDownMaster;
  const MaintenanceView({this.appDownMaster, super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  appDownMaster?.appDownImageUrl ??
                      "https://cdn3d.iconscout.com/3d/premium/thumb/gears-3d-illustration-download-in-png-blend-fbx-gltf-file-formats--cogwheel-configuration-cog-glass-morphism-pack-user-interface-illustrations-4696750.png?f=webp",
                  height: 240,
                ),
                kCommonSpaceV10,
                Text(
                  appDownMaster?.appDownMessage ?? "Under Maintenance",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kCommonSpaceV10,
                Text(
                  appDownMaster?.appDownHeader ??
                      "Delivery service closed today, it will resume from tomorrow.",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
