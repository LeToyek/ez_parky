import 'package:flutter/material.dart';
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

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
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
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['GOOGLE_MAP_API_KEY']!,
      const PointLatLng(-7.8675462, 112.680094),
      const PointLatLng(-7.950982275096204, 112.6397738845435),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
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
    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
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
              Marker(
                markerId: const MarkerId("destination"),
                position: destination,
                icon: destinationIcon,
              ),
            },
            initialCameraPosition: CameraPosition(
              target: _center!,
              zoom: 11.0,
            ),
          ),
          if (!_isMapCreated) const Center(child: CircularProgressIndicator())
        ],
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
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }
}
