import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({super.key});

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  kCommonSpaceH15,
                  Expanded(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kCommonSpaceV5,
            Container(
              width: double.infinity,
              height: 200.0,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ),
            kCommonSpaceV5,
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  kCommonSpaceH15,
                  Expanded(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kCommonSpaceV5,
            Container(
              width: double.infinity,
              height: 100.0,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ),
            kCommonSpaceV5,
          ],
        ),
      ),
    );
  }
}
