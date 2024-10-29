import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/home/profile/add_address/select_address/select_address_map_view.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widget/common_appbar.dart';
import '../../../../widget/primary_button.dart';
import '../edit_account/edit_account_view.dart';
import 'add_address_view_model.dart';

class AddAddressView extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String currentAddress;

  const AddAddressView(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.currentAddress});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  TextEditingController edBuildingController = TextEditingController();
  TextEditingController edLandMarkController = TextEditingController();
  TextEditingController edNameController = TextEditingController();
  TextEditingController edPhoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int selectedIndex = 0;
  String selectedAddressType = 'Home';

  final List<String> addressTypes = ["Home", "Work", "Other"];

  final List<IconData> addressIcons = [
    Icons.home,
    Icons.work,
    Icons.location_on
  ];

  late AddAddressViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      edNameController.text = globalUserMaster?.name ?? '';
      edPhoneNumberController.text = globalUserMaster?.mobile ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AddAddressViewModel>(context);

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
                          horizontal: 2, vertical: 2),
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
                    Flexible(
                      child: Text(
                        widget.currentAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: getAppStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final latLng = LatLng(
                          widget.latitude,
                          widget.longitude,
                        );
                        print(latLng.latitude);
                        print(latLng.longitude);
                        push(SelectAddressMapView(selectedPlace: latLng));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border: Border.all(
                              color: CommonColors.primaryColor, width: 1.3),
                        ),
                        child: Center(
                          child: Text(
                            "Change",
                            style: getAppStyle(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormFieldCustom(
                        controller: edBuildingController,
                        textInputType: TextInputType.text,
                        hintText: "House No. and Building Name",
                        labelText: "House No. and Building Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter House No. and Building Name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKey.currentState?.validate() == true) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormFieldCustom(
                        controller: edLandMarkController,
                        textInputType: TextInputType.text,
                        hintText: "Road/Area and nearby landmark",
                        labelText: "Road/Area and nearby landmark",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Road/Area and nearby landmark';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKey.currentState?.validate() == true) {
                            _formKey.currentState!.validate();
                          }
                        },
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (_formKey.currentState?.validate() == true) {
                                  _formKey.currentState!.validate();
                                }
                              },
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Phone Number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (_formKey.currentState?.validate() == true) {
                                  _formKey.currentState!.validate();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Save this address as",
                          style: getAppStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: addressTypes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedAddressType = addressTypes[index];
                                });
                              },
                              child: Container(
                                width: 90,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: selectedIndex == index
                                      ? CommonColors.primaryColor
                                          .withOpacity(0.2)
                                      : Colors.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      addressIcons[index],
                                      color: CommonColors.black54,
                                      size: 22,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      addressTypes[index],
                                      style: getAppStyle(
                                        color: CommonColors.black54,
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
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: PrimaryButton(
            height: 40,
            label: "Save and Continue",
            lblSize: 16,
            borderRadius: BorderRadius.circular(6),
            onPress: () {
              if (_formKey.currentState!.validate()) {
                mViewModel.addAddressApi(
                    latitude: widget.latitude.toString(),
                    longitude: widget.longitude.toString(),
                    name: edNameController.text,
                    mobileNo: edPhoneNumberController.text,
                    landmark: edLandMarkController.text,
                    address: widget.currentAddress,
                    houseNo: edBuildingController.text,
                    type: selectedAddressType);
              }
            },
          ),
        ),
      ),
    );
  }
}
