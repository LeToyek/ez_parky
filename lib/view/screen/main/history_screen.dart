import 'dart:ui' as ui;

import 'package:ez_parky/repository/model/parking_gate_model.dart';
import 'package:ez_parky/repository/provider/parking_location_provider.dart';
import 'package:ez_parky/view/widgets/ez_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  late GoogleMapController mapController;

  LatLng? _center = const LatLng(-7.8675462, 112.680094);
  List<LatLng> polylineCoordinates = [];
  bool _isMapCreated = false;

  LatLng destination = const LatLng(-7.950982275096204, 112.6397738845435);
  LatLng userDestination = const LatLng(-7.950982275096204, 112.6397738845435);

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor userLocationIcon = BitmapDescriptor.defaultMarker;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "lib/assets/pin_destination.png")
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)), "lib/assets/logo.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
    getBytesFromAsset("lib/assets/user_pin.png", 100).then((value) {
      userLocationIcon = BitmapDescriptor.fromBytes(value);
    });
  }

  void getPolyPoints({required double desLat, required double desLng}) async {
    polylineCoordinates.clear();
    final currentLocation = await _currentLocation();
    destination = LatLng(desLat, desLng);
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['GOOGLE_MAP_API_KEY']!,
      PointLatLng(currentLocation.latitude!, currentLocation.longitude!),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    setState(() {});
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    setCustomMarkerIcon();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    final resLocation = _currentLocation();
    resLocation.then((value) {
      setState(() {
        _isMapCreated = true;
        _center = LatLng(value.latitude!, value.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final parkingGates = ref.watch(parkingLocationProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            parkingGates.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                data: (data) {
                  final gates = data;
                  final gatesMarker = gates.map((e) {
                    return Marker(
                      markerId: MarkerId(e.id!),
                      position: LatLng(e.latitude, e.longitude),
                      icon: sourceIcon,
                      onTap: () =>
                          showDestinationModal(textTheme, colorScheme, e),
                    );
                  }).toList();
                  return GoogleMap(
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        points: polylineCoordinates,
                        color: colorScheme.primary,
                        width: 6,
                      ),
                    },
                    onMapCreated: _onMapCreated,
                    markers: {
                      ...gatesMarker.toSet(),
                      Marker(
                          markerId: const MarkerId("user"),
                          position: userDestination,
                          icon: userLocationIcon)
                    },
                    initialCameraPosition: CameraPosition(
                      target: _center!,
                      zoom: 11.0,
                    ),
                  );
                }),
            polylineCoordinates.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EzCard(
                        isShadow: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("data"),
                                IconButton(
                                    onPressed: () {
                                      print("clear");
                                      setState(() {
                                        polylineCoordinates.clear();
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            )
                          ],
                        )),
                  )
                : Container(),
            if (!_isMapCreated) const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        heroTag: 'fb_map',
        backgroundColor: Colors.white,
        onPressed: _currentLocation,
        splashColor: colorScheme.error,
        icon: Icon(
          Icons.control_camera,
          color: colorScheme.error,
        ),
        label: Text(
          "re - center",
          style: textTheme.bodyMedium!
              .apply(fontWeightDelta: 2, color: colorScheme.error),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<LocationData> _currentLocation() async {
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
      userDestination =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: userDestination,
          zoom: 17.0,
        ),
      ));
      print("currentLocation: $currentLocation");
      return currentLocation;
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.warning),
            content: Text(
              "$e",
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () => context.pop(), child: const Text("Tutup"))
            ],
          );
        },
      );
      rethrow;
    }
  }

  void showDestinationModal(
      TextTheme textTheme, ColorScheme colorScheme, ParkingGate e) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              e.location,
              style: textTheme.headlineSmall!.apply(fontWeightDelta: 2),
            ),
            const SizedBox(
              height: 16,
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Jl. Raya Tenggilis No. 1"),
              subtitle: Text("Surabaya, Jawa Timur"),
            ),
            const ListTile(
              leading: Icon(Icons.access_time),
              title: Text("Jam Buka"),
              subtitle: Text("08.00 - 22.00"),
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text("Tarif"),
              subtitle: Text("Rp. ${e.price} / jam"),
            ),
            ListTile(
              leading: const Icon(Icons.local_parking),
              title: const Text("Kapasitas"),
              subtitle: Text(e.capacity.toString()),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                        onPressed: () {
                          getPolyPoints(
                              desLat: e.latitude, desLng: e.longitude);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: Text(
                          "Menuju Lokasi",
                          style: textTheme.bodyLarge!.apply(
                              fontWeightDelta: 2,
                              fontSizeDelta: 4,
                              color: colorScheme.onPrimary),
                        )),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }
}
