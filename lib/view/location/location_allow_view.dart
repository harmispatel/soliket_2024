import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/utils/common_utils.dart';
import 'package:solikat_2024/utils/constant.dart';

import '../../utils/common_colors.dart';
import '../../widget/common_appbar.dart';
import '../../widget/primary_button.dart';
import 'location_donNot_allow_view.dart';
import 'location_view_model.dart';

class LocationAllowView extends StatefulWidget {
  final LatLng? selectedPlace;

  LocationAllowView({this.selectedPlace});

  @override
  _LocationAllowViewState createState() => _LocationAllowViewState();
}

class _LocationAllowViewState extends State<LocationAllowView> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  Marker? _userMarker;
  bool _isLoading = true;
  String _currentAddress = 'Fetching address...';
  String _mainArea = 'Fetching area...';
  late LocationViewModel mViewModel;

  LatLng? _mapCenter;
  String _locationError = '';
  bool _isAddressFetching = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      // phoneController.text = "+91 ";
      if (widget.selectedPlace != null) {
        _currentPosition = widget.selectedPlace;
        _mapCenter = _currentPosition;
      } else {
        _getUserLocation();
      }
    });
  }

  Future<void> _getUserLocation() async {
    setState(() {
      _isLoading = true;
      _locationError = ''; // Reset error message
    });

    if (await Permission.location.request().isGranted) {
      try {
        // Get current position
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _mapCenter = _currentPosition;
        });

        // Move the camera to the user's current location
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition!, zoom: 15.0),
        ));

        // Fetch the address
        _getAddressFromLatLng(_currentPosition!);
      } catch (e) {
        setState(() {
          _locationError = 'Failed to get your location. Please try again.';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _locationError = 'Location permission not granted.';
        _isLoading = false;
      });
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    if (_isAddressFetching) return;
    _isAddressFetching = true;

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      String mainArea = place.subLocality ?? place.name ?? 'Unknown Area';
      String fullAddress =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      setState(() {
        _currentAddress = fullAddress;
        _mainArea = mainArea;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Unable to get address.";
        _isLoading = false;
      });
    } finally {
      _isAddressFetching = false;
    }
  }

  void _onCameraIdle() {
    if (_mapCenter != null) {
      _getAddressFromLatLng(_mapCenter!);
    }
  }

  void _onCameraMove(CameraPosition position) {
    _mapCenter = position.target; // Update map center on camera move
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<LocationViewModel>(context);

    return Scaffold(
      appBar: CommonAppBar(
        title: "Confirm Delivery Location",
        isTitleBold: true,
        isShowShadow: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          if (_currentPosition != null)
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 15.0,
              ),
              onCameraMove: _onCameraMove,
              onCameraIdle: _onCameraIdle,
            ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (!_isLoading && _locationError.isEmpty) ...[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: CommonColors.primaryColor,
                      shape: TooltipShapeBorder(arrowArc: 0.2),
                      shadows: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Order will be delivered here',
                            style: getAppStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(
                            'Place the pin accurately on the map',
                            style:
                                getAppStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _getUserLocation();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: CommonColors.mWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 5), // Shadow position
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, left: 15, right: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.my_location,
                              color: CommonColors.primaryColor,
                            ),
                            kCommonSpaceH10,
                            Text(
                              "Locate Me",
                              style: getAppStyle(
                                  color: CommonColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kCommonSpaceV15,
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CommonColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: CommonColors.primaryColor.withOpacity(0.3),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: CommonColors.primaryColor
                                          .withOpacity(0.5),
                                      width: 2.0,
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
                                kCommonSpaceH15,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _mainArea,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      kCommonSpaceV3,
                                      Text(
                                        _currentAddress,
                                        style:
                                            TextStyle(fontSize: 13, height: 1),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var status =
                                        await Permission.location.status;
                                    bool isHavePermission = false;

                                    if (status.isGranted) {
                                      isHavePermission = true;
                                    }
                                    push(LocationDoNotAllowView());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: CommonColors.mWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: CommonColors.primaryColor
                                            .withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        "Change",
                                        style: getAppStyle(
                                            color: CommonColors.primaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: CommonColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                            border: Border(
                              top: BorderSide(
                                color:
                                    CommonColors.primaryColor.withOpacity(0.3),
                                width: 1.0,
                              ),
                              left: BorderSide(
                                color:
                                    CommonColors.primaryColor.withOpacity(0.3),
                                width: 1.0,
                              ),
                              right: BorderSide(
                                color:
                                    CommonColors.primaryColor.withOpacity(0.3),
                                width: 1.0,
                              ),
                              // No bottom border
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: PrimaryButton(
                              height: 55,
                              label: "Confirm Location",
                              lblSize: 18,
                              onPress: () {
                                mViewModel.confirmLocationApi(
                                    latitude:
                                        _currentPosition?.latitude.toString() ??
                                            '',
                                    longitude: _currentPosition?.longitude
                                            .toString() ??
                                        '',
                                    location: _currentAddress);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_locationError.isNotEmpty)
            Center(
              child: Text(
                _locationError,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }
}

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  TooltipShapeBorder({
    this.radius = 16.0,
    this.arrowWidth = 20.0,
    this.arrowHeight = 15.0,
    this.arrowArc = 0.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // Implement if necessary
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx + x / 2, rect.bottomCenter.dy)
      ..relativeLineTo(-x / 2 * r, y * r)
      ..relativeQuadraticBezierTo(
          -x / 2 * (1 - r), y * (1 - r), -x * (1 - r), 0)
      ..relativeLineTo(-x / 2 * r, -y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Add custom painting if needed
  }

  @override
  ShapeBorder scale(double t) => this;
}
