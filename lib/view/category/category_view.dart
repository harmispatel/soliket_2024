import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../widget/common_appbar.dart';
import '../home/sub_category/sub_category_view.dart';
import 'category_view_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late CategoryViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getCategoryApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CategoryViewModel>(context);
    return Scaffold(
      // backgroundColor: const Color(0xFFFFF4E8),
      appBar: CommonAppBar(
        title: "Category",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: mViewModel.isInitialLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: GridView.builder(
                padding: kCommonScreenPadding,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.9,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 40,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Flexible(
                          flex: 8,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : GridView.builder(
              padding: kCommonScreenPadding,
              cacheExtent: 9999.0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              shrinkWrap: true,
              itemCount: mViewModel.categoryListData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    push(
                      SubCategoryView(
                        categoryId: mViewModel
                            .categoryListData[index].categoryId
                            .toString(),
                        title:
                            mViewModel.categoryListData[index].categoryName ??
                                '',
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Flexible(
                        flex: 6,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FancyShimmerImage(
                            shimmerBaseColor: Colors.white30,
                            imageUrl: mViewModel
                                    .categoryListData[index].categoryImage ??
                                '',
                            boxFit: BoxFit.fill,
                          ),

                          // Container(
                          //   clipBehavior: Clip.antiAlias,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image: NetworkImage(mViewModel
                          //               .categoryListData[index]
                          //               .categoryImage ??
                          //           ''),
                          //       fit: BoxFit.fill,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Flexible(
                        flex: 2,
                        child: Text(
                          mViewModel.categoryListData[index].categoryName ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getAppStyle(
                              fontWeight: FontWeight.w500,
                              height: 1,
                              fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
