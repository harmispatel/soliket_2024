import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';

class TrackingOrdersView extends StatefulWidget {
  const TrackingOrdersView({super.key});

  @override
  State<TrackingOrdersView> createState() => _TrackingOrdersViewState();
}

class _TrackingOrdersViewState extends State<TrackingOrdersView> {
  late GoogleMapController mapController;

  // Ahmedabad to Dhandhuka coordinates
  double _originLatitude = 23.0225, _originLongitude = 72.5714; // Ahmedabad
  double _destLatitude = 22.7981, _destLongitude = 72.3764; // Dhandhuka

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBuZVlcMCQy7Y8rRfhYEXSODG0_Ryx14R8";

  @override
  void initState() {
    super.initState();

    // Origin marker (Ahmedabad)
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    // Destination marker (Dhandhuka)
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));

    // Get polyline between origin and destination
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Track Order",
          isTitleBold: true,
          isShowShadow: true,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            GestureDetector(
              onTap: () {
                print("Refresh");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: CommonColors.primaryColor.withOpacity(0.1),
                    border: Border.all(color: CommonColors.primaryColor)),
                child: Row(
                  children: [
                    const Icon(Icons.refresh,
                        size: 18, color: CommonColors.blackColor),
                    kCommonSpaceH2,
                    Text(
                      "Refresh",
                      style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: kCommonScreenPadding,
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red),
                      child: const Icon(
                        Icons.clear,
                        color: CommonColors.mWhite,
                      ),
                    ),
                    kCommonSpaceH15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Cancelled",
                          style: getAppStyle(
                              color: CommonColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        kCommonSpaceV3,
                        Text(
                          "Order Cancelled",
                          style: getAppStyle(
                              color: CommonColors.mGrey500,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Divider(
                  color: CommonColors.mGrey300,
                  thickness: 4,
                ),
              ),
              Padding(
                padding: kCommonScreenPadding,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                        kCommonSpaceH15,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Boy Name",
                              style: getAppStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: CommonColors.blackColor),
                            ),
                            Text(
                              "Not Assigned",
                              style: getAppStyle(
                                  fontSize: 14, color: CommonColors.black54),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Divider(
                            color: CommonColors.mGrey300,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Divider(
                        color: CommonColors.mGrey300,
                        thickness: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.call,
                            ),
                          ),
                        ),
                        kCommonSpaceH15,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mobile Number",
                              style: getAppStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: CommonColors.blackColor),
                            ),
                            Text(
                              "Not Assigned",
                              style: getAppStyle(
                                  fontSize: 14, color: CommonColors.black54),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Divider(
                            color: CommonColors.mGrey300,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Divider(
                  color: CommonColors.mGrey300,
                  thickness: 4,
                  height: 2,
                ),
              ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_originLatitude, _originLongitude),
                    zoom: 10,
                  ),
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  markers: Set<Marker>.of(markers.values),
                  polylines: Set<Polyline>.of(polylines.values),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  // Add marker to map
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    );
    markers[markerId] = marker;
  }

  // Add polyline to map
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      width: 5,
      polylineId: id,
      color: CommonColors.primaryColor,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  // Get polyline between origin and destination
  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPiKey,
      request: PolylineRequest(
        origin: PointLatLng(_originLatitude, _originLongitude),
        destination: PointLatLng(_destLatitude, _destLongitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
