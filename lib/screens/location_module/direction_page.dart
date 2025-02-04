import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DirectionsPage extends StatefulWidget {
  final LatLng destinate;
  final LatLng originate;

  const DirectionsPage({
    Key? key,
    required this.destinate,
    required this.originate,
  }) : super(key: key);

  @override
  _DirectionsPageState createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  late GoogleMapController _controller;
  late List<LatLng> _polylineCoordinates = [];
  late Set<Polyline> _polylines = {};
  late Set<Marker> _markers = {};
  late String distanceData = '';
  late String durationData = '';

  void _showBottomSheetModal() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Wait for data to be ready
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
            child: Container(
              width: double.infinity,
              height: 250, // Adjust the height as needed
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/store.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Highties Cannabies Stores',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "FontMain",
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 25),
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    'assets/images/range.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: distanceData,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'FontMain',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.solidClock,
                                  color: Color(0xff007AFF),
                                  size: 20,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: " :  ${durationData}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FontMain',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.locationCrosshairs,
                                  color: Color(0xff007AFF),
                                  size: 20,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: " : 1044 Saint Guillaume Road, Unit A102",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FontMain',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

//https://maps.googleapis.com/maps/api/directions/json?origin=45.502807,-75.786914&destination=47.32103,8.7218&key=AIzaSyBPtWb6QfjhGSqwv2dPXhZgxWnZ14cgI1w
  void _getDirections() async {
    try {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${widget.originate.latitude},${widget.originate.longitude}&destination=${widget.destinate.latitude},${widget.destinate.longitude}&key=AIzaSyBPtWb6QfjhGSqwv2dPXhZgxWnZ14cgI1w'));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['routes'] != null && decoded['routes'].isNotEmpty) {
          final route = decoded['routes'][0];
          if (route['overview_polyline'] != null &&
              route['overview_polyline']['points'] != null) {
            final points = _decodePoly(
                route['overview_polyline']['points']); // Using a library
            final distance = route['legs'][0]['distance']['text'];
            final duration = route['legs'][0]['duration']['text'];

            setState(() {
              _polylineCoordinates = points;
              distanceData = distance;
              durationData = duration;
            });

            _addPolyline();
          }
        }
      } else {
        // Handle API error
        print('Error fetching directions: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error fetching directions: $e');
    }
  }

  List<LatLng> _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = <LatLng>[];
    int index = 0;
    int len = poly.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = list[index++] - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = list[index++] - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      var latLng = LatLng(lat / 1E5, lng / 1E5);
      lList.add(latLng);
    }
    return lList;
  }

  void _addPolyline() async {
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route1'),
        points: _polylineCoordinates,
        width: 7,
        color: const Color(0xff2A6443),
      ),
    );

    BitmapDescriptor originIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          size: Size(48, 48)), // Adjust the size if necessary
      'assets/images/mine.png',
    );

    BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          size: Size(48, 48)), // Adjust the size if necessary
      'assets/images/Group68.png',
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('origin'),
        position: widget.originate,
        icon: originIcon,
        infoWindow: const InfoWindow(title: 'Origin'),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: widget.destinate,
        icon: destinationIcon,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getDirections();

    print("widget.originate");
    print(widget.originate);

    print("widget.destinate");
    print(widget.destinate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: const Text('Map with Directions')),
      body: GoogleMap(
        polylines: _polylines,
        initialCameraPosition: CameraPosition(
          target: widget.originate,
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
      ),
    );
  }
}
