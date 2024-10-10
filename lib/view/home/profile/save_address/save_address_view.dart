import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/widget/common_appbar.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../add_address/add_address_view.dart';

class SaveAddressView extends StatefulWidget {
  const SaveAddressView({super.key});

  @override
  State<SaveAddressView> createState() => _SaveAddressViewState();
}

class _SaveAddressViewState extends State<SaveAddressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.mGrey200,
      appBar: CommonAppBar(
        title: "Saved Addresses",
        isShowShadow: true,
        isTitleBold: true,
        iconTheme: IconThemeData(color: CommonColors.blackColor),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [AddressListView()],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          push(AddAddressView());
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: CommonColors.primaryColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add New Address",
                style: getAppStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Icon(
                  Icons.add,
                  color: CommonColors.primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// * My Cart List View * //

class AddressListView extends StatefulWidget {
  const AddressListView({super.key});

  @override
  State<AddressListView> createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Work",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 02),
                          child: Text(
                            "abc",
                            style: getAppStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          "+91-1234567890",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("OnTap Edit Button");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color:
                                    CommonColors.primaryColor.withOpacity(0.2)),
                          ),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: getAppStyle(
                                color: CommonColors.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("OnTap Remove Text Button");
                        },
                        child: Text(
                          "Remove",
                          style: getAppStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
