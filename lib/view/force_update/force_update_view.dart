import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solikat_2024/utils/local_images.dart';
import 'package:solikat_2024/widget/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/common_colors.dart';
import '../../utils/constant.dart';

class ForceUpdateView extends StatefulWidget {
  const ForceUpdateView({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (_) => const ForceUpdateView());

  @override
  State<ForceUpdateView> createState() => _ForceUpdateViewState();
}

class _ForceUpdateViewState extends State<ForceUpdateView> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: CommonColors.grayShade200,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: CommonColors.grayShade200),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Image.asset(
              height: 100,
              width: 100,
              LocalImages.img_refresh,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 64),
            Text(
              "App Update",
              style: getAppStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 33, bottom: 30),
              child: Text(
                "Cool new features are in! For a smooth and awesome experience, please update the app.",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: getAppStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(
              height: 55,
              label: "Update App",
              buttonColor: CommonColors.primaryColor,
              labelColor: CommonColors.mWhite,
              onPress: () {
                openStoreListing();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openStoreListing() async {
    const url =
        "https://play.google.com/store/apps/details?id=com.ludo.king&pcampaignid=web_share";
    if (url.isNotEmpty) {
      await tryLaunch(url);
    } else {
      log("No URL provided for $url platform");
    }
  }

  Future<bool> tryLaunch(
    String link, {
    Function()? onCannotLaunch,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      try {
        return await launchUrl(
          uri,
          mode: mode,
          webViewConfiguration: const WebViewConfiguration(),
        );
      } catch (e) {
        log("Error launching $link: $e");
        onCannotLaunch?.call();
      }
    } else {
      log("Cannot launch $link");
      onCannotLaunch?.call();
    }
    return false;
  }
}
