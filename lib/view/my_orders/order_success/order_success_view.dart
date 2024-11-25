import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../widget/common_appbar.dart';
import '../../../widget/primary_button.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view.dart';
import '../../common_view/bottom_navbar/bottom_navbar_view_model.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

// A custom Path to paint paper pieces
Path drawPaperPiece(Size size) {
  final path = Path();
  path.moveTo(size.width, 0);
  path.lineTo(size.width - 10, 0);
  path.lineTo(size.width - 10, size.height);
  path.lineTo(size.width, size.height);
  path.close();
  return path;
}

// A custom Path to paint stars
Path drawStar(Size size) {
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

// Method to randomly select between drawing a star or a paper piece
Path drawRandomConfetti(Size size) {
  final random = Random();
  return random.nextBool() ? drawStar(size) : drawPaperPiece(size);
}

class _OrderSuccessViewState extends State<OrderSuccessView> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();
    _controllerTopCenter = ConfettiController();
    _controllerTopCenter.play();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        mainNavKey.currentContext!
            .read<BottomNavbarViewModel>()
            .onMenuTapped(2);

        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BottomNavBarView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
          (Route<dynamic> route) => false,
        );

        return false;
      },
      child: Stack(
        children: [
          SafeArea(
            child: Scaffold(
              backgroundColor: CommonColors.mWhite,
              appBar: CommonAppBar(
                title: "Order Confirmed",
                iconTheme: IconThemeData(color: CommonColors.blackColor),
                isShowShadow: true,
                isTitleBold: true,
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 160, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ_KPMKbQ0JLUNVf4Ac-aOFTRQpHPlK6V-Qw&s",
                      height: 200,
                    ),
                    kCommonSpaceV20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Text(
                        "Your Order Has Been Placed You Will Receive on Email Receive Shortly",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            fontSize: 18,
                            color: CommonColors.blackColor),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        print("Order Tracking");
                      },
                      child: Column(
                        children: [
                          Text(
                            "Order Tracking",
                            textAlign: TextAlign.center,
                            style: getAppStyle(
                              color: CommonColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 112,
                            color: CommonColors.primaryColor,
                          )
                        ],
                      ),
                    ),
                    kCommonSpaceV20,
                    PrimaryButton(
                      height: 55,
                      label: "Order Continue",
                      buttonColor: CommonColors.primaryColor,
                      labelColor: CommonColors.mWhite,
                      onPress: () {
                        print("Order Continue");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              // Confetti will only blast once
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              createParticlePath: drawRandomConfetti,
              // randomly pick between paper and stars
              numberOfParticles: 50,
              // Number of particles
              emissionFrequency: 0.5,
              // Faster emission frequency (lower value = more frequent emission)
              gravity: 1, // Increased gravity to make the confetti fall faster
            ),
          ),
        ],
      ),
    );
  }
}