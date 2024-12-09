import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/constant.dart';
import 'package:solikat_2024/view/profile/add_address/select_address/select_address_map_view.dart';

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
  final bool isFromCart;

  const AddAddressView({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.currentAddress,
    required this.isFromCart,
  });

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  TextEditingController edHouseNoController = TextEditingController();
  TextEditingController edRoadNameController = TextEditingController();
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
      mViewModel.isFromCart = widget.isFromCart;
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
        appBar: const CommonAppBar(
          title: "Add Address",
          isShowShadow: true,
          isTitleBold: true,
          iconTheme: const IconThemeData(color: CommonColors.blackColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Address change container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                width: double.infinity,
                color: const Color(0xffe1ecfe),
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
                        border: Border.all(color: const Color(0xff195dc0)),
                      ),
                      child: const Icon(Icons.location_on_rounded,
                          color: Color(0xff195dc0)),
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
                        push(SelectAddressMapView(
                          selectedPlace: latLng,
                          isFromEdit: false,
                        ));
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
                              color: const Color(0xff195dc0), width: 1.3),
                        ),
                        child: Center(
                          child: Text(
                            "Change",
                            style: getAppStyle(
                              color: const Color(0xff195dc0),
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
                        verticalPadding: 15,
                        controller: edHouseNoController,
                        textInputType: TextInputType.text,
                        hintText: "House No., Building Name",
                        labelText: "House No., Building Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'House No., Building Name (Required)*';
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
                        verticalPadding: 15,
                        controller: edRoadNameController,
                        textInputType: TextInputType.text,
                        hintText: "Road name, Area, Colony",
                        labelText: "Road name, Area, Colony",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Road name, Area, Colony (Required)*';
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
                              verticalPadding: 15,
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
                              verticalPadding: 15,
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
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
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
                                      ? const Color(0xffe1ecfe)
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
            // buttonColor: Color(0xff195dc0),
            buttonColor: CommonColors.primaryColor,
            borderRadius: BorderRadius.circular(6),
            onPress: () {
              if (_formKey.currentState!.validate()) {
                mViewModel.addAddressApi(
                    latitude: widget.latitude.toString(),
                    longitude: widget.longitude.toString(),
                    name: edNameController.text,
                    mobileNo: edPhoneNumberController.text,
                    area: edRoadNameController.text,
                    address: widget.currentAddress,
                    houseName: edHouseNoController.text,
                    type: selectedAddressType,
                    isDefault: widget.isFromCart ? "y" : "n");
              }
            },
          ),
        ),
      ),
    );
  }
}
