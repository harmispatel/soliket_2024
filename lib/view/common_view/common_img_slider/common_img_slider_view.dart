import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CommonImgSliderView extends StatefulWidget {
  final List<String> imgUrls;
  const CommonImgSliderView({super.key, required this.imgUrls});

  @override
  State<CommonImgSliderView> createState() => _CommonImgSliderViewState();
}

class _CommonImgSliderViewState extends State<CommonImgSliderView> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgUrls.map((item) {
      return FancyShimmerImage(
        shimmerBaseColor: Colors.white30,
        imageUrl: item,
        boxFit: BoxFit.cover,
      );

      CachedNetworkImage(
        imageUrl: item,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.image),
      );
    }).toList();
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgUrls.asMap().entries.map((entry) {
            int index = entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 6.0,
              width: 6.0,
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.black : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
