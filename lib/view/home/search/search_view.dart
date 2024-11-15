import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/home/search/search_view_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../utils/common_colors.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widget/common_text_field.dart';

class SearchView extends StatefulWidget {
  final String voiceText;
  const SearchView({super.key, required this.voiceText});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  bool _isSpeaking = false;
  int itemCount = 0;

  late SearchViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      _scrollController.addListener(_scrollListener);
      if (widget.voiceText.isNotEmpty) {
        searchController.text = widget.voiceText;
        mViewModel.getSearchDataApi(
          latitude: gUserLat,
          longitude: gUserLong,
          keyWord: searchController.text.trim(),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    mViewModel.currentPage = 1;
    mViewModel.productList.clear();
    searchController.clear();
    super.dispose();
  }

  void _scrollListener() {
    final mViewModel = context.read<SearchViewModel>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !mViewModel.isPageFinish) {
      mViewModel.getSearchDataApi(
        latitude: gUserLat,
        longitude: gUserLong,
        keyWord: searchController.text.trim(),
      );
    }
  }

  void incrementItem() {
    setState(() {
      itemCount++;
    });
    // widget.onIncrement!();
  }

  void decrementItem() {
    if (itemCount > 0) {
      setState(() {
        itemCount--;
      });
      // widget.onDecrement!();
    }
  }

  /// Start listening for speech input
  void _startListening() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() {
        _isListening = true;
        _isSpeaking = true;
      });

      _showBottomSheet(context);

      _speechToText.listen(
        onResult: (result) {
          setState(() {
            searchController.text = result.recognizedWords;
          });
        },
        listenFor: Duration(seconds: 3),
        pauseFor: Duration(seconds: 3),
        partialResults: true,
        onSoundLevelChange: (level) {},
      );
      // Automatically close the dialog after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        if (_isListening) {
          _stopListening();
          mViewModel.getSearchDataApi(
            latitude: gUserLat,
            longitude: gUserLong,
            keyWord: searchController.text,
          );
        }
      });
    } else {
      print("Speech recognition not available.");
    }
  }

  /// Stop listening when the user pauses or finishes speaking
  void _stopListening() {
    _speechToText.stop();
    setState(() {
      _isListening = false;
      _isSpeaking = false;
    });

    Navigator.of(context).pop();
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(height: 200, LocalImages.speakingGif),
                SizedBox(height: 20),
                Text(
                  "Listening...",
                  style: getAppStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SearchViewModel>(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CommonTextField(
            controller: searchController,
            hintText: "Search",
            isPrefixIconButton: true,
            prefixIcon: Icons.arrow_back,
            onPrefixIconPressed: () {
              Navigator.pop(context);
            },
            suffixIcon: Icons.mic,
            onSuffixIconPressed: () {
              if (_isListening) {
                _stopListening();
              } else {
                _startListening();
              }
            },
            isIconButton: true,
            onEditComplete: (value) {
              if (value.length >= 3) {
                mViewModel.currentPage = 1;
                mViewModel.productList.clear();
                mViewModel.getSearchDataApi(
                  latitude: gUserLat,
                  longitude: gUserLong,
                  keyWord: value,
                );
              } else if (value.length <= 2) {
                setState(() {
                  mViewModel.productList.clear();
                });
              }
            },
          )),
      body: mViewModel.productList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset(height: 350, LocalImages.noProductGif),
              ),
            )
          // Shimmer.fromColors(
          //         baseColor: Colors.grey.shade300,
          //         highlightColor: Colors.grey.shade100,
          //         enabled: true,
          //         child: SingleChildScrollView(
          //           padding: kCommonScreenPadding,
          //           child: Column(
          //             children: [
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           height: 200.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV10,
          //                         Container(
          //                           height: 20.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV5,
          //                         Container(
          //                           height: 14.0,
          //                           width: 130,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV15,
          //                         Row(
          //                           children: [
          //                             Expanded(
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Container(
          //                                     height: 12.0,
          //                                     width: 80,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                   kCommonSpaceV5,
          //                                   Container(
          //                                     height: 12.0,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             kCommonSpaceH5,
          //                             kCommonSpaceH3,
          //                             Expanded(
          //                               child: Container(
          //                                 height: 35.0,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(12.0),
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                   kCommonSpaceH15,
          //                   Expanded(
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           height: 200.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV10,
          //                         Container(
          //                           height: 20.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV5,
          //                         Container(
          //                           height: 14.0,
          //                           width: 130,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV15,
          //                         Row(
          //                           children: [
          //                             Expanded(
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Container(
          //                                     height: 12.0,
          //                                     width: 80,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                   kCommonSpaceV5,
          //                                   Container(
          //                                     height: 12.0,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             kCommonSpaceH5,
          //                             kCommonSpaceH3,
          //                             Expanded(
          //                               child: Container(
          //                                 height: 35.0,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(12.0),
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               kCommonSpaceV15,
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           height: 200.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV10,
          //                         Container(
          //                           height: 20.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV5,
          //                         Container(
          //                           height: 14.0,
          //                           width: 130,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV15,
          //                         Row(
          //                           children: [
          //                             Expanded(
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Container(
          //                                     height: 12.0,
          //                                     width: 80,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                   kCommonSpaceV5,
          //                                   Container(
          //                                     height: 12.0,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             kCommonSpaceH5,
          //                             kCommonSpaceH3,
          //                             Expanded(
          //                               child: Container(
          //                                 height: 35.0,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(12.0),
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                   kCommonSpaceH15,
          //                   Expanded(
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           height: 200.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV10,
          //                         Container(
          //                           height: 20.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV5,
          //                         Container(
          //                           height: 14.0,
          //                           width: 130,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV15,
          //                         Row(
          //                           children: [
          //                             Expanded(
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Container(
          //                                     height: 12.0,
          //                                     width: 80,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                   kCommonSpaceV5,
          //                                   Container(
          //                                     height: 12.0,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             kCommonSpaceH5,
          //                             kCommonSpaceH3,
          //                             Expanded(
          //                               child: Container(
          //                                 height: 35.0,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(12.0),
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               kCommonSpaceV15,
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           height: 200.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV10,
          //                         Container(
          //                           height: 20.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV5,
          //                         Container(
          //                           height: 14.0,
          //                           width: 130,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV15,
          //                         Row(
          //                           children: [
          //                             Expanded(
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Container(
          //                                     height: 12.0,
          //                                     width: 80,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                   kCommonSpaceV5,
          //                                   Container(
          //                                     height: 12.0,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             kCommonSpaceH5,
          //                             kCommonSpaceH3,
          //                             Expanded(
          //                               child: Container(
          //                                 height: 35.0,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(12.0),
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                   kCommonSpaceH15,
          //                   Expanded(
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           height: 200.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV10,
          //                         Container(
          //                           height: 20.0,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV5,
          //                         Container(
          //                           height: 14.0,
          //                           width: 130,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12.0),
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                         kCommonSpaceV15,
          //                         Row(
          //                           children: [
          //                             Expanded(
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Container(
          //                                     height: 12.0,
          //                                     width: 80,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                   kCommonSpaceV5,
          //                                   Container(
          //                                     height: 12.0,
          //                                     decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(12.0),
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             kCommonSpaceH5,
          //                             kCommonSpaceH3,
          //                             Expanded(
          //                               child: Container(
          //                                 height: 35.0,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(12.0),
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          : GridView.builder(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              shrinkWrap: true,
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 2,
                mainAxisSpacing: 5,
              ),
              itemCount: mViewModel.productList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 170,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  if (mViewModel.productList[index].stock != 0)
                                    Center(
                                      child: Image.network(
                                        mViewModel.productList[index].image ??
                                            '',
                                        fit: BoxFit.contain,
                                        height: 170,
                                      ),
                                    ),
                                  if (mViewModel.productList[index].stock == 0)
                                    Center(
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.white.withOpacity(0.5),
                                          BlendMode
                                              .srcOver, // Blend mode for overlay
                                        ),
                                        child: Image.network(
                                          mViewModel.productList[index].image ??
                                              '',
                                          fit: BoxFit.contain,
                                          height: 170,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 40,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    mViewModel.productList[index].productName ??
                                        '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: getAppStyle(
                                        fontSize: 14,
                                        color: mViewModel
                                                    .productList[index].stock ==
                                                0
                                            ? Colors.grey[400]
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  mViewModel.productList[index].variantName ??
                                      '',
                                  style: getAppStyle(
                                    fontSize: 14,
                                    color:
                                        mViewModel.productList[index].stock == 0
                                            ? Colors.grey[400]
                                            : Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mViewModel
                                              .productList[index].discountPrice
                                              .toString(),
                                          style: getAppStyle(
                                            fontSize: 14,
                                            color: mViewModel.productList[index]
                                                        .stock ==
                                                    0
                                                ? Colors.grey[400]
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          mViewModel
                                              .productList[index].productPrice
                                              .toString(),
                                          style: getAppStyle(
                                            color: mViewModel.productList[index]
                                                        .stock ==
                                                    0
                                                ? Colors.grey[400]
                                                : Colors.black54,
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (mViewModel.productList[index].stock !=
                                        0) ...[
                                      itemCount > 0
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              margin: const EdgeInsets.only(
                                                  bottom: 4),
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color:
                                                    CommonColors.primaryColor,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: decrementItem,
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    itemCount.toString(),
                                                    style: getAppStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: incrementItem,
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : InkWell(
                                              onTap: incrementItem,
                                              child: Container(
                                                width: 100,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: CommonColors
                                                          .primaryColor,
                                                      width: 1),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Add",
                                                    style: getAppStyle(
                                                      color: CommonColors
                                                          .primaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (mViewModel.productList[index].discountPer != 0 &&
                            mViewModel.productList[index].stock != 0)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Text(
                                  "${mViewModel.productList[index].discountPer}% off",
                                  style: getAppStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (mViewModel.productList[index].stock == 0)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 100),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color:
                                    CommonColors.primaryColor.withOpacity(0.2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: const Offset(
                                      2.0,
                                      4.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.5,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 3),
                                child: Text(
                                  "Sorry, this item is sold out",
                                  textAlign: TextAlign.center,
                                  style: getAppStyle(
                                      color: CommonColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      height: 1.2),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
