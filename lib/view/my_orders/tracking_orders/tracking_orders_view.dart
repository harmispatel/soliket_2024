import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/view/my_orders/tracking_orders/tracking_orders_view_model.dart';

import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';

class TrackingOrdersView extends StatefulWidget {
  final String orderId;

  const TrackingOrdersView({super.key, required this.orderId});

  @override
  State<TrackingOrdersView> createState() => _TrackingOrdersViewState();
}

class _TrackingOrdersViewState extends State<TrackingOrdersView> {
  late GoogleMapController mapController;
  late TrackingOrdersViewModel mViewModel;

  double fromLatitude = 0.0, fromLongitude = 0.0;
  double toLatitude = 0.0, toLongitude = 0.0;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBuZVlcMCQy7Y8rRfhYEXSODG0_Ryx14R8";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      getTrackingData();
    });
  }

  void getTrackingData() {
    mViewModel.trackingOrderApi(orderId: widget.orderId).whenComplete(() {
      fromLatitude =
          double.parse(mViewModel.trackOrderData[0].fromLatitude ?? '');
      fromLongitude =
          double.parse(mViewModel.trackOrderData[0].fromLongitude ?? '');
      toLatitude = double.parse(mViewModel.trackOrderData[0].toLatitude ?? '');
      toLongitude =
          double.parse(mViewModel.trackOrderData[0].toLongitude ?? '');
    }).whenComplete(() {
      _addMarker(LatLng(fromLatitude, fromLongitude), "origin",
          BitmapDescriptor.defaultMarker);

      _addMarker(LatLng(toLatitude, toLongitude), "destination",
          BitmapDescriptor.defaultMarkerWithHue(90));

      _getPolyline();

      print("From latitude.................. $fromLatitude");
      print("From longitude................. $fromLongitude");
      print("to latitude.................... $toLatitude");
      print("to longitude................... $toLongitude");
    });
  }

  @override
  void dispose() {
    fromLatitude = 0.0;
    fromLongitude = 0.0;
    toLatitude = 0.0;
    toLongitude = 0.0;
    mViewModel.isInitialLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<TrackingOrdersViewModel>(context);
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
                getTrackingData();
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
        body: mViewModel.isInitialLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: ListView.builder(
                    itemCount: 15,
                    padding: kCommonScreenPadding,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          width: double.infinity,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
              )
            : Padding(
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
                                "Order Status",
                                style: getAppStyle(
                                    color: CommonColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              kCommonSpaceV3,
                              Text(
                                mViewModel.trackOrderData[0].orderStatus ?? '',
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
                                    mViewModel.trackOrderData[0].riderName ??
                                        '',
                                    style: getAppStyle(
                                        fontSize: 14,
                                        color: CommonColors.black54),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
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
                                    mViewModel.trackOrderData[0].riderMobile ??
                                        '',
                                    style: getAppStyle(
                                        fontSize: 14,
                                        color: CommonColors.black54),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
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
                          target: LatLng(fromLatitude, fromLongitude),
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
        origin: PointLatLng(fromLatitude, fromLongitude),
        destination: PointLatLng(toLatitude, toLongitude),
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
