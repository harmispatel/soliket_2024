import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../widget/common_appbar.dart';
import '../../widget/common_text_field.dart';
import '../../widget/primary_button.dart';
import 'location_allow_view.dart';

class PlacesService {
  final String apiKey;

  PlacesService(this.apiKey);

  Future<List<dynamic>> searchPlaces(String query) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['predictions']; // List of suggestions
    } else {
      throw Exception('Failed to load places');
    }
  }
}

class LocationDoNotAllowView extends StatefulWidget {
  const LocationDoNotAllowView({super.key});

  @override
  State<LocationDoNotAllowView> createState() => _LocationDoNotAllowViewState();
}

class _LocationDoNotAllowViewState extends State<LocationDoNotAllowView>
    with WidgetsBindingObserver {
  final TextEditingController searchController = TextEditingController();
  var status;
  bool isHavePermission = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // Check location permission when the app is resumed
      _checkLocationPermission();
    }
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      setState(() {
        isHavePermission = true;
      });
    } else {
      setState(() {
        isHavePermission = false;
      });
    }
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    print(status);

    // Check if permission is permanently denied
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else if (status.isDenied) {
      // Retry requesting permission if it was denied
      await Permission.location.request();
    }

    // Handle permission granted or not
    if (status.isGranted) {
      setState(() {
        isHavePermission = true;
      });
    } else {
      setState(() {
        isHavePermission = false;
      });
    }
  }

  final PlacesService _placesService =
      PlacesService('AIzaSyBuZVlcMCQy7Y8rRfhYEXSODG0_Ryx14R8');
  List<dynamic> _suggestions = [];

  void _onSearchChanged(String value) async {
    if (value.isNotEmpty) {
      final results = await _placesService.searchPlaces(value);
      setState(() {
        _suggestions = results;
      });
      print(_suggestions);
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  Future<Map<String, dynamic>> fetchPlaceDetails(String placeId) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=AIzaSyBuZVlcMCQy7Y8rRfhYEXSODG0_Ryx14R8'));
    if (response.statusCode == 200) {
      return jsonDecode(
          response.body)['result']; // Adjust based on your API response
    } else {
      throw Exception('Failed to load place details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Search Delivery Location",
          isTitleBold: true,
          isShowShadow: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            kCommonSpaceV15,
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: LabeledTextField(
                hintText: "Search your location",
                onEditComplete: _onSearchChanged,
                prefixIcon:
                    Icon(Icons.search, color: CommonColors.primaryColor),
                controller: searchController,
              ),
            ),
            kCommonSpaceV10,
            Container(
              height: 4,
              color: CommonColors.mGrey200.withOpacity(0.5),
            ),
            kCommonSpaceV15,
            isHavePermission
                ? GestureDetector(
                    onTap: () {
                      push(LocationAllowView());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.my_location,
                              color: CommonColors.primaryColor,
                            ),
                            kCommonSpaceH10,
                            Text(
                              "Use current location",
                              style: getAppStyle(
                                  color: CommonColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: CommonColors.primaryColor,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: CommonColors.primaryColor,
                          ),
                          kCommonSpaceH10,
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location Permission is off",
                                  style: getAppStyle(
                                      color: CommonColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                kCommonSpaceV3,
                                Text(
                                  "please location permission for the best delivery experience",
                                  style: getAppStyle(height: 1, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          kCommonSpaceH10,
                          PrimaryButton(
                            height: 35,
                            width: 90,
                            label: "Grant",
                            onPress: () {
                              _showAlertDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            kCommonSpaceV15,
            Container(
              height: 4,
              color: CommonColors.mGrey200.withOpacity(0.5),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              _suggestions[index]['structured_formatting']
                                  ['main_text'],
                              style: getAppStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          subtitle: Text(
                            _suggestions[index]['description'],
                            style: getAppStyle(height: 1.1),
                          ),
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    CommonColors.primaryColor.withOpacity(0.3),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.location_on,
                                size: 17,
                                color: CommonColors.primaryColor,
                              ),
                            ),
                          ),
                          onTap: () async {
                            final placeId = _suggestions[index]['place_id'];
                            if (placeId != null) {
                              // Make a separate API call to get details about this place
                              final response = await fetchPlaceDetails(placeId);
                              if (response != null &&
                                  response['geometry'] != null) {
                                final location =
                                    response['geometry']['location'];
                                final latLng = LatLng(
                                  location['lat'],
                                  location['lng'],
                                );
                                push(LocationAllowView(selectedPlace: latLng));
                              } else {
                                // Handle case where location data is still missing
                                print(
                                    'Location data is still missing after API call.');
                                // Optionally show an alert or a Snackbar
                              }
                            } else {
                              print('Place ID is missing.');
                              // Handle the case where place ID is not available
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          height: 1,
                          color: CommonColors.mGrey300,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              kCommonSpaceV10,
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: CommonColors.mGrey300, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.close,
                        size: 15,
                        color: CommonColors.mWhite,
                      ),
                    ),
                  ),
                ),
              ),
              kCommonSpaceV15,
              Text(
                'Turn on location permission',
                style: getAppStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              kCommonSpaceV5,
              Text(
                textAlign: TextAlign.center,
                'Please go to Settings > Location to turn on Location Permission',
                style: getAppStyle(color: CommonColors.black54, height: 1.2),
              ),
              kCommonSpaceV20,
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      height: 50,
                      label: "Cancel",
                      labelColor: CommonColors.primaryColor,
                      buttonColor: CommonColors.primaryColor.withOpacity(0.3),
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  kCommonSpaceH15,
                  Expanded(
                    child: PrimaryButton(
                      height: 50,
                      label: "Settings",
                      onPress: () {
                        Navigator.pop(context);
                        requestLocationPermission();
                      },
                    ),
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
