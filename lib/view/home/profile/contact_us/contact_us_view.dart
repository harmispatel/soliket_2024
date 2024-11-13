import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widget/common_appbar.dart';
import 'contact_us_view_model.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  late ContactUsViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getContactUsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ContactUsViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CommonAppBar(
        title: "Contact Us",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: SingleChildScrollView(
        padding: kCommonScreenPadding,
        child: Column(
          children: [
            if (!mViewModel.isInitialLoading) ...[
              Card(
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.shade200,
                //         spreadRadius: 1,
                //         blurRadius: 1,
                //         offset: const Offset(0, 1),
                //       ),
                //     ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Support",
                        style: getAppStyle(
                            fontSize: 15, color: CommonColors.black54),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.contactUsList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                // Container(
                                //   decoration: BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: CommonColors.mGrey200),
                                //   child: const Padding(
                                //     padding: EdgeInsets.all(8.0),
                                //     child: Icon(
                                //       Icons.email,
                                //       color: CommonColors.black54,
                                //       size: 22,
                                //     ),
                                //   ),
                                // ),
                                Image.network(
                                    height: 35,
                                    width: 35,
                                    mViewModel.contactUsList[index].icon ?? ''),
                                kCommonSpaceH10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mViewModel.contactUsList[index].title ??
                                          '',
                                      style: getAppStyle(
                                          fontSize: 12,
                                          color: CommonColors.black54),
                                    ),
                                    Text(
                                      mViewModel.contactUsList[index].value ??
                                          '',
                                      style: getAppStyle(fontSize: 16),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
