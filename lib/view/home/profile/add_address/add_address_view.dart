import 'package:flutter/material.dart';

import '../../../../utils/common_colors.dart';
import '../../../../widget/common_appbar.dart';
import '../../../../widget/primary_button.dart';
import '../edit_account/edit_account_view.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  TextEditingController edBuildingController = TextEditingController();
  TextEditingController edLandMarkController = TextEditingController();
  TextEditingController edNameController = TextEditingController();
  TextEditingController edPhoneNumberController = TextEditingController();

  int selectedIndex = 0;

  final List<String> addressTypes = ["Home", "Work", "Other"];

  final List<IconData> addressIcons = [
    Icons.home,
    Icons.work,
    Icons.location_on
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: "Add Address",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: IconThemeData(color: CommonColors.blackColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Address change container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                width: double.infinity,
                color: CommonColors.primaryColor.withOpacity(0.2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        border: Border.all(color: CommonColors.primaryColor),
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    const Flexible(
                      child: Text(
                        "Ravinagar, Station Road, Moudhanagar",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("OnTap Change Button");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border: Border.all(color: CommonColors.primaryColor),
                        ),
                        child: const Center(
                          child: Text(
                            "Change",
                            style: TextStyle(
                              color: CommonColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20) +
                    const EdgeInsets.only(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldCustom(
                      controller: edBuildingController,
                      textInputType: TextInputType.text,
                      hintText: "House No. and Building Name",
                      labelText: "House No. and Building Name",
                    ),
                    const SizedBox(height: 18),
                    TextFormFieldCustom(
                      controller: edLandMarkController,
                      textInputType: TextInputType.text,
                      hintText: "Road/Area and nearby landmark",
                      labelText: "Road/Area and nearby landmark",
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormFieldCustom(
                            controller: edNameController,
                            textInputType: TextInputType.name,
                            hintText: "Name",
                            labelText: "Name",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormFieldCustom(
                            maxLength: 10,
                            controller: edPhoneNumberController,
                            textInputType: TextInputType.number,
                            hintText: "Phone Number",
                            labelText: "Phone Number",
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        "Save this address as",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: addressTypes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              width: 90,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: selectedIndex == index
                                    ? CommonColors.primaryColor.withOpacity(0.2)
                                    : Colors.white,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    addressIcons[index],
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    addressTypes[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: PrimaryButton(
            height: 32,
            label: "Save and Continue",
            lblSize: 16,
            borderRadius: BorderRadius.circular(6),
            onPress: () {},
          ),
        ),
      ),
    );
  }
}
