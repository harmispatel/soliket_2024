import 'package:flutter/material.dart';
import '../../utils/common_colors.dart';
import '../../utils/constant.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "https://cdn3d.iconscout.com/3d/premium/thumb/gears-3d-illustration-download-in-png-blend-fbx-gltf-file-formats--cogwheel-configuration-cog-glass-morphism-pack-user-interface-illustrations-4696750.png?f=webp",
                  height: 240,
                ),
                kCommonSpaceV10,
                Text(
                  "Under Maintenance",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kCommonSpaceV10,
                Text(
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
