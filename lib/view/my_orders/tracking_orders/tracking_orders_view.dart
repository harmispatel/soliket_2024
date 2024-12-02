import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solikat_2024/view/my_orders/tracking_orders/tracking_orders_view_model.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widget/common_appbar.dart';
import 'package:image/image.dart' as img;

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
  // void getTrackingData() {
  //   mViewModel.trackingOrderApi(orderId: widget.orderId).whenComplete(() {
  //     fromLatitude =
  //         double.parse(mViewModel.trackOrderData[0].fromLatitude ?? '');
  //     fromLongitude =
  //         double.parse(mViewModel.trackOrderData[0].fromLongitude ?? '');
  //     toLatitude = double.parse(mViewModel.trackOrderData[0].toLatitude ?? '');
  //     toLongitude =
  //         double.parse(mViewModel.trackOrderData[0].toLongitude ?? '');
  //   }).whenComplete(() {
  //     _addMarker(LatLng(fromLatitude, fromLongitude), "origin",
  //         BitmapDescriptor.defaultMarker);
  //
  //     _addMarker(LatLng(toLatitude, toLongitude), "destination",
  //         BitmapDescriptor.defaultMarkerWithHue(90));
  //
  //     _getPolyline();
  //
  //     print("From latitude.................. $fromLatitude");
  //     print("From longitude................. $fromLongitude");
  //     print("to latitude.................... $toLatitude");
  //     print("to longitude................... $toLongitude");
  //   });
  // }

  void getTrackingData() async {
    await mViewModel.trackingOrderApi(orderId: widget.orderId).whenComplete(() {
      fromLatitude =
          double.parse(mViewModel.trackOrderData[0].fromLatitude ?? '');
      fromLongitude =
          double.parse(mViewModel.trackOrderData[0].fromLongitude ?? '');
      toLatitude = double.parse(mViewModel.trackOrderData[0].toLatitude ?? '');
      toLongitude =
          double.parse(mViewModel.trackOrderData[0].toLongitude ?? '');
    }).whenComplete(() async {
      // //Optionally, you can load custom images:
      // BitmapDescriptor originIcon = await BitmapDescriptor.fromAssetImage(
      //   ImageConfiguration(devicePixelRatio: 4),
      //   'assets/images/img_app_logo.png',
      // );
      // BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
      //   ImageConfiguration(devicePixelRatio: 4),
      //   'assets/images/img_app_logo.png',
      // );
      BitmapDescriptor originIcon =
          await _getCustomMarker('assets/images/img_app_logo.png', 200, 200);
      BitmapDescriptor destinationIcon =
          await _getCustomMarker('assets/images/img_app_logo.png', 200, 200);

      _addMarker(LatLng(fromLatitude, fromLongitude), "origin", originIcon);
      _addMarker(
          LatLng(toLatitude, toLongitude), "destination", destinationIcon);
      _getPolyline();
      print("From latitude.................. $fromLatitude");
      print("From longitude................. $fromLongitude");
      print("To latitude.................... $toLatitude");
      print("To longitude................... $toLongitude");
    });
  }

  Future<BitmapDescriptor> _getCustomMarker(
      String assetPath, double width, double height) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    img.Image resizedImage =
        img.copyResize(image, width: width.toInt(), height: height.toInt());
    final resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));
    return BitmapDescriptor.fromBytes(resizedBytes);
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
                    Container(
                      width: kDeviceWidth,
                      color: CommonColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.access_time,
                                  color: CommonColors.mWhite,
                                ),
                              ),
                            ),
                            kCommonSpaceH15,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Status",
                                  style: getAppStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: CommonColors.mWhite),
                                ),
                                Text(
                                  mViewModel.trackOrderData[0].orderStatus ??
                                      '',
                                  style: getAppStyle(
                                      fontSize: 16, color: CommonColors.mWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    kCommonSpaceV10,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: CommonColors.primaryColor
                                    .withOpacity(0.3 / 2),
                                shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.person,
                                color: CommonColors.primaryColor,
                              ),
                            ),
                          ),
                          kCommonSpaceH15,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Driver Name",
                                style: getAppStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: CommonColors.blackColor),
                              ),
                              Text(
                                mViewModel.trackOrderData[0].riderName ?? '',
                                style: getAppStyle(
                                    fontSize: 14, color: CommonColors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Divider(
                        color: CommonColors.mGrey500,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6) +
                          const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: CommonColors.primaryColor
                                    .withOpacity(0.3 / 2),
                                shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.call,
                                color: CommonColors.primaryColor,
                              ),
                            ),
                          ),
                          kCommonSpaceH15,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Driver Mobile No",
                                  style: getAppStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: CommonColors.blackColor),
                                ),
                                Text(
                                  mViewModel.trackOrderData[0].riderMobile ??
                                      '',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                      fontSize: 14,
                                      color: CommonColors.black54),
                                ),
                              ],
                            ),
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
                    )
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
