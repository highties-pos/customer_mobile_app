// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:highties_cannabis/screens/notification.dart';
// import 'package:highties_cannabis/widgets/button.dart';
// import 'package:location/location.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   List<Map<String, dynamic>> placesList = [
//     {
//       "id": "1",
//       "store_name": "Andheri",
//       "store_address": "Andheri Railway",
//       "coordinates": {"lat": 47.27103, "lng": 8.8218}
//     },
//     {
//       "id": "2",
//       "store_name": "DOWNTOWN -H",
//       "store_address": "484 RIDEAU STREET, OTTAWA K1N 5Z4",
//       "coordinates": {"lat": 45.430918, "lng": -75.679875}
//     },
//     {
//       "id": "3",
//       "store_name": "EMBRUN -H",
//       "store_address": "825 NOTRE-DAME STREET, EMBRUN K0A 1W1",
//       "coordinates": {"lat": 45.2688769, "lng": -75.2958197}
//     },
//     {
//       "id": "4",
//       "store_name": "PLANTAGENET -H",
//       "store_address": "5787 COUNTY RD 17,PLANTAGENET, ON, K0B1L0",
//       "coordinates": {"lat": 45.431171, "lng": -74.679428}
//     },
//     {
//       "id": "5",
//       "store_name": "TENTH LINE -H",
//       "store_address": "2284 TENTH LINE UNIT F5, ORLÉANS, K4A",
//       "coordinates": {"lat": 45.431171, "lng": 74.4715}
//     },
//     {
//       "id": "6",
//       "store_name": "VANIER -H",
//       "store_address": "179 MONTREAL ROAD, OTTAWA K1L 6E4",
//       "coordinates": {"lat": 45.435132, "lng": -75.664724}
//     },
//     {
//       "id": "7",
//       "store_name": "BLACKBURN -H",
//       "store_address": "2518-2520 INNES RD, GLOUCESTER, ON K1B 3J9",
//       "coordinates": {"lat": 45.429371, "lng": -75.569648}
//     },
//   ];

//   late GoogleMapController mapController;

//   String _searchText = '';

//   final LatLng myLocation = const LatLng(
//     45.502807,
//     -75.786914,
//   );

//   Set<Marker> _markers = {};
//   BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

//   @override
//   void initState() {
//     super.initState();
//     addCustomIcon();
//   }

//   Future<void> addCustomIcon() async {
//     markerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       "assets/images/newLoc.png",
//     );
//     setState(() {
//       _addMarkers();
//     }); // Trigger a rebuild after the custom icon is loaded
//   }

//   void _addMarkers() {
//     _markers.clear();
//     placesList.forEach((place) {
//       final LatLng position = LatLng(
//         place['coordinates']['lat'],
//         place['coordinates']['lng'],
//       );
//       _markers.add(
//         Marker(
//           markerId: MarkerId(place['id']),
//           position: position,
//           onTap: () => _showModal(place),
//           icon: markerIcon,
//         ),
//       );
//     });
//   }

//   void _showModal(Map<String, dynamic> place) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/images/store.png',
//                     width: 180,
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: 100,
//                         child: Text(
//                           place['store_name'],
//                           style: const TextStyle(
//                               fontFamily: "FontMain",
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Colors.blue,
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'In-store Shopping',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Colors.blue,
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Kerbside Pickup',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Colors.blue,
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Delivery',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               RichText(
//                 text: const TextSpan(
//                   children: [
//                     WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.solidClock,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Friday, 9am - 10pm',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               RichText(
//                 text: const TextSpan(
//                   children: [
//                     WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.phone,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text: '+13628292902',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 height: 20,
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     const WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.locationPin,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text: place['store_address'],
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // You can add distance calculation here
//             ],
//           ),
//           actions: [
//             Buttons(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               title: 'Directions',
//               height: 45,
//               width: 150,
//               colors: const Color(0xffC8EDD9),
//               textColors: const Color(0xff027335),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   double xoffSet = 0;
//   double yoffSet = 0;
//   bool isDrawerOpen = false;

//   List<Map<String, dynamic>> get filteredPlacesList {
//     return placesList
//         .where((place) => place['store_name']!
//             .toLowerCase()
//             .contains(_searchText.toLowerCase()))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Check if markerIcon is null or not initialized before showing the map
//     if (markerIcon == null) {
//       return const CircularProgressIndicator(); // Or any loading indicator
//     }

//     return SafeArea(
//       child: AnimatedContainer(
//         transform: Matrix4.translationValues(xoffSet, yoffSet, 0)
//           ..scale(isDrawerOpen ? 0.85 : 1.00)
//           ..rotateZ(isDrawerOpen ? -50 : 0),
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(40)),
//         child: Stack(
//           children: [
//             GoogleMap(
//               onMapCreated: (controller) {
//                 mapController = controller;
//               },
//               compassEnabled: false,
//               initialCameraPosition: CameraPosition(
//                 target: myLocation,
//                 zoom: 11.0,
//               ),
//               markers: _markers,
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         isDrawerOpen
//                             ? InkWell(
//                                 child: const Card(
//                                   shape: CircleBorder(),
//                                   color: Color(0xff2A6443),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: FaIcon(
//                                       FontAwesomeIcons.xmark,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     xoffSet = 0;
//                                     yoffSet = 0;
//                                     isDrawerOpen = false;
//                                   });
//                                 },
//                               )
//                             : InkWell(
//                                 child: const Card(
//                                   shape: CircleBorder(),
//                                   color: Color(0xff2A6443),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: FaIcon(
//                                       FontAwesomeIcons.bars,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     xoffSet = 360;
//                                     yoffSet = 80;
//                                     isDrawerOpen = true;
//                                   });
//                                 },
//                               ),
//                         InkWell(
//                           child: const Card(
//                             shape: CircleBorder(),
//                             color: Color(0xff2A6443),
//                             child: Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: FaIcon(
//                                 FontAwesomeIcons.solidBell,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           onTap: () {
//                             Get.to(() => const NotificationPage(),
//                                 transition: Transition.rightToLeft);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           onChanged: (value) {
//                             setState(() {
//                               _searchText = value;
//                             });
//                           },
//                           decoration: InputDecoration(
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             hintText: 'Search Location...',
//                             hintStyle: const TextStyle(fontFamily: 'FontMain'),
//                             prefixIcon: const Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(13),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   // Conditional rendering of places list
//                   if (_searchText.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(13),
//                             color: Colors.grey[200]),
//                         child: Column(
//                           children: [
//                             for (int i = 0; i < filteredPlacesList.length; i++)
//                               Column(
//                                 children: [
//                                   ListTile(
//                                     leading: const FaIcon(
//                                       FontAwesomeIcons.solidCircle,
//                                       size: 9,
//                                     ),
//                                     title: Text(
//                                       filteredPlacesList[i]['store_name']!,
//                                       style: const TextStyle(
//                                           fontFamily: 'FontMain', fontSize: 13),
//                                     ),
//                                     subtitle: Text(
//                                       filteredPlacesList[i]['store_address']!,
//                                       style: const TextStyle(
//                                           fontFamily: 'FontMain', fontSize: 10),
//                                     ),
//                                   ),
//                                   if (i != filteredPlacesList.length - 1)
//                                     const Divider(
//                                       thickness: 1,
//                                       height: 0,
//                                       indent: 16,
//                                       endIndent: 16,
//                                     ),
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






////API intergration Updated code

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highties_cannabis/http/api_request.dart';
// import 'package:highties_cannabis/screens/notification.dart';
// import 'package:highties_cannabis/widgets/button.dart';
// import 'package:http/http.dart' as http;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;

//   String _searchText = '';
//   List<String> _suggestions = [];

//   final LatLng myLocation = const LatLng(
//     45.502807,
//     -75.786914,
//   );

//   Set<Marker> _markers = {};
//   BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

//   @override
//   void initState() {
//     super.initState();
//     addCustomIcon();
//     getWarehouseMarker();
//   }

//   Future<void> addCustomIcon() async {
//     markerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       "assets/images/newLoc.png",
//     );
//     setState(() {
//       _addMarkers();
//     }); // Trigger a rebuild after the custom icon is loaded
//   }

//   void _addMarkers() {
//     _markers.clear();
//     for (var warehouse in warehouseMarkerDataInfo) {
//       double latitude = double.parse(warehouse['latitude'].toString());
//       double longitude = double.parse(warehouse['longitude'].toString());
//       String warehouseName = warehouse['name'].toString();

//       // Create a marker for the warehouse
//       Marker marker = Marker(
//         markerId: MarkerId(warehouseName),
//         position: LatLng(latitude, longitude),
//         icon: markerIcon,
//         onTap: () {
//           // Show modal dialog when marker is tapped
//           _showModal(warehouse);
//         },
//       );

//       // Add the marker to the set of markers
//       _markers.add(marker);
//     }
//   }

//   // Function to fetch suggestions from the API
//   Future<void> fetchSuggestions(String input) async {
//     final response = await http.get(
//       Uri.parse('http://3.96.170.126:4000/api/warehouses?search=$input'),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data =
//           json.decode(response.body.toString())['result'];
//       setState(() {
//         _suggestions.clear();
//         _suggestions.addAll(data.map((e) => e['name'].toString()));
//       });
//     } else {
//       throw Exception('Failed to load suggestions');
//     }
//   }

//   var warehouseMarkerRes;
//   var warehouseMarkerData;
//   List warehouseMarkerDataInfo = [];

//   Future getWarehouseMarker() async {
//     try {
//       warehouseMarkerRes = await getReq("/warehouses");

//       if (warehouseMarkerRes.statusCode == 200) {
//         warehouseMarkerData = jsonDecode(warehouseMarkerRes.body.toString());

//         setState(() {
//           warehouseMarkerDataInfo = warehouseMarkerData['result'];
//           _addMarkers(); // Call _addMarkers here to add markers when warehouse data is fetched
//         });
//         print("warehouseMarkerDataInfo:");
//         print(warehouseMarkerDataInfo);
//       } else {
//         print(
//             "Error fetching warehouses details. Status code: ${warehouseMarkerRes.statusCode}");
//         print(warehouseMarkerRes.body.toString());
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   void _showModal(Map<String, dynamic> warehouse) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/images/store.png',
//                     width: 180,
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: 100,
//                         child: Text(
//                           "${warehouse['name']}(${warehouse['company']})",
//                           style: const TextStyle(
//                               fontFamily: "FontMain",
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Colors.blue,
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'In-store Shopping',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Colors.blue,
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Kerbside Pickup',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Colors.blue,
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Delivery',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               RichText(
//                 text: const TextSpan(
//                   children: [
//                     WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.solidClock,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Friday, 9am - 10pm',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     const WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.phone,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text: warehouse['phone_no'],
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 height: 20,
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     const WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.locationPin,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text:
//                           "${warehouse['address_line_1'] ?? ''}${warehouse['address_line_2'] ?? ''}${warehouse['city'] ?? ''}${warehouse['state'] ?? ''}${warehouse['pin'] ?? ''} ",
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // You can add distance calculation here
//             ],
//           ),
//           actions: [
//             Buttons(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               title: 'Directions',
//               height: 45,
//               width: 150,
//               colors: const Color(0xffC8EDD9),
//               textColors: const Color(0xff027335),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   double xoffSet = 0;
//   double yoffSet = 0;
//   bool isDrawerOpen = false;

// @override
// Widget build(BuildContext context) {
//   // Check if markerIcon is null or not initialized before showing the map
//   if (markerIcon == null) {
//     return const CircularProgressIndicator(); // Or any loading indicator
//   }

//   return Scaffold(
//     body: SafeArea(
//       child: AnimatedContainer(
//         transform: Matrix4.translationValues(xoffSet, yoffSet, 0)
//           ..scale(isDrawerOpen ? 0.85 : 1.00)
//           ..rotateZ(isDrawerOpen ? -50 : 0),
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(40)),
//         child: Stack(
//           children: [
//             GoogleMap(
//               onMapCreated: (controller) {
//                 mapController = controller;
//               },
//               // myLocationEnabled: true, // Enable showing user's location
//               // myLocationButtonEnabled: true, // Enable the my location button
//               compassEnabled: false,
//               initialCameraPosition: CameraPosition(
//                 target: myLocation,
//                 zoom: 11.0,
//               ),
//               markers: _markers,
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         isDrawerOpen
//                             ? InkWell(
//                                 child: const Card(
//                                   shape: CircleBorder(),
//                                   color: Color(0xff2A6443),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: FaIcon(
//                                       FontAwesomeIcons.xmark,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     xoffSet = 0;
//                                     yoffSet = 0;
//                                     isDrawerOpen = false;
//                                   });
//                                 },
//                               )
//                             : InkWell(
//                                 child: const Card(
//                                   shape: CircleBorder(),
//                                   color: Color(0xff2A6443),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: FaIcon(
//                                       FontAwesomeIcons.bars,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     xoffSet = 360;
//                                     yoffSet = 80;
//                                     isDrawerOpen = true;
//                                   });
//                                 },
//                               ),
//                         InkWell(
//                           child: const Card(
//                             shape: CircleBorder(),
//                             color: Color(0xff2A6443),
//                             child: Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: FaIcon(
//                                 FontAwesomeIcons.solidBell,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           onTap: () {
//                             Get.to(() => const NotificationPage(),
//                                 transition: Transition.rightToLeft);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 25),
//   child: Card(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         onChanged: (value) {
//           setState(() {
//             _searchText = value;
//           });
//           fetchSuggestions(value);
//         },
//         decoration: InputDecoration(
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           hintText: 'Search Location...',
//           hintStyle:
//               const TextStyle(fontFamily: 'FontMain'),
//           prefixIcon: const Icon(Icons.search),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(13),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),

// Conditional rendering of suggestions list
// if (_searchText.isNotEmpty)
//   Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 30),
//     child: Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(13),
//           color: Colors.grey[200]),
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: _suggestions.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_suggestions[index]),
//             onTap: () {
//               // Handle suggestion selection
//             },
//           );
//         },
//       ),
//     ),
//   ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:highties_cannabis/alert/toast.dart';
// import 'package:highties_cannabis/http/api_request.dart';
// import 'package:highties_cannabis/model/customer/get_all_store_model.dart';
// import 'package:highties_cannabis/screens/location_module/direction_page.dart';
// import 'package:highties_cannabis/screens/location_module/maps_new.dart';
// import 'package:highties_cannabis/screens/notification.dart';
// import 'package:highties_cannabis/screens/store_details/store_detail.dart';
// import 'package:highties_cannabis/widgets/button.dart';
// import 'package:location/location.dart';
// import 'package:http/http.dart' as http;

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;
//   late Position currentPosition;
//   String _searchText = '';
//   List<String> _suggestions = [];

//   final LatLng myLocation = const LatLng(45.502807, -75.786914);

//   Set<Marker> _markers = {};
//   BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

//   @override
//   void initState() {
//     super.initState();
//     addCustomIcon();
//     getWarehouseMarker();
//     // _getUserLocation();
//   }

//   Future<void> _getUserLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, handle accordingly
//       return;
//     }

//     // Check location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Location permissions are denied, handle accordingly
//         return;
//       }
//     }

//     // Get current position
//     currentPosition = await Geolocator.getCurrentPosition();

//     setState(() {
//       // Set the initial camera position to the current position
//       mapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(currentPosition.latitude, currentPosition.longitude),
//             zoom: 15,
//           ),
//         ),
//       );
//     });
//   }

//   Future<void> addCustomIcon() async {
//     markerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       "assets/images/Group68.png",
//     );
//     setState(() {
//       _addMarkers();
//     }); // Trigger a rebuild after the custom icon is loaded
//   }

//   void _addMarkers() {
//     _markers.clear();
//     for (int index = 0; index < warehouseMarkerDataInfo.length; index++) {
//       var warehouse = warehouseMarkerDataInfo[index];
//       double latitude = double.parse(warehouse['latitude'].toString());
//       double longitude = double.parse(warehouse['longitude'].toString());
//       String warehouseName = warehouse['name'].toString();

//       // Create a marker for the warehouse
//       Marker marker = Marker(
//         markerId: MarkerId(warehouseName),
//         position: LatLng(latitude, longitude),
//         icon: markerIcon,
//         onTap: () {
//           // Show modal dialog when marker is tapped
//           _showModal(warehouse, index); // Pass the warehouse and index
//         },
//       );

//       // Add the marker to the set of markers
//       _markers.add(marker);
//     }
//   }

//   //  final response = await http.get(Uri.parse(
//   //       'https://maps.googleapis.com/maps/api/directions/json?origin=${widget.originate.toString()}&destination=${widget.destinate.toString()}&key=AIzaSyBPtWb6QfjhGSqwv2dPXhZgxWnZ14cgI1w'));
//   List<Map<String, dynamic>> _suggestionsData = [];
//   List<Map<String, dynamic>> storeListData = [];
//   // Function to fetch suggestions from the API
//   Future<void> fetchSuggestions(String input) async {
//     final response = await http.get(
//       Uri.parse('http://3.96.170.126:4000/api/warehouses?search=$input'),
//     );
//     if (response.statusCode == 200) {
//       final List<dynamic> data =
//           json.decode(response.body.toString())['result'];
//       setState(() {
//         _suggestionsData = data.map<Map<String, dynamic>>((e) {
//           return {
//             'name': e['name'],
//             'address_line_1': e['address_line_1'],
//             'address_line_2': e['address_line_2'],
//             'city': e['city'],
//             'state': e['state'],
//             'pin': e['pin'],
//             'phone_no': e['phone_no'],
//             'latitude': e['latitude'],
//             'longitude': e['longitude'],
//           };
//         }).toList();
//       });
//     } else {
//       throw Exception('Failed to load suggestions');
//     }
//   }

//   var warehouseMarkerRes;
//   var warehouseMarkerData;
//   List warehouseMarkerDataInfo = [];

//   Future getWarehouseMarker() async {
//     try {
//       warehouseMarkerRes = await getReq("/warehouses");

//       if (warehouseMarkerRes.statusCode == 200) {
//         warehouseMarkerData = jsonDecode(warehouseMarkerRes.body.toString());

//         setState(() {
//           warehouseMarkerDataInfo = warehouseMarkerData['result'];
//           _addMarkers(); // Call _addMarkers here to add markers when warehouse data is fetched
//         });
//         print("warehouseMarkerDataInfo:");
//         print(warehouseMarkerDataInfo);
//       } else {
//         print(
//             "Error fetching warehouses details. Status code: ${warehouseMarkerRes.statusCode}");
//         print(warehouseMarkerRes.body.toString());
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   void _showModal(Map<String, dynamic> warehouse, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/images/store.png',
//                     width: 180,
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: 100,
//                         child: Text(
//                           "${warehouse['name']}(${warehouse['company']})",
//                           style: const TextStyle(
//                               fontFamily: "FontMain",
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Color(0xff007AFF),
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'In-store Shopping',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Color(0xff007AFF),
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Kerbside Pickup',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             WidgetSpan(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 8.0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.check,
//                                   color: Color(0xff007AFF),
//                                   size: 13,
//                                 ),
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Delivery',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'FontMain',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               RichText(
//                 text: const TextSpan(
//                   children: [
//                     WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.solidClock,
//                           color: Color(0xff007AFF),
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Friday, 9am - 10pm',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     const WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.phone,
//                           color: Color(0xff007AFF),
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text: warehouse['phone_no'],
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 height: 20,
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     const WidgetSpan(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: FaIcon(
//                           FontAwesomeIcons.locationDot,
//                           color: Color(0xff007AFF),
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     TextSpan(
//                       text:
//                           "${warehouse['address_line_1'] ?? ''}${warehouse['address_line_2'] ?? ''}${warehouse['city'] ?? ''}${warehouse['state'] ?? ''}${warehouse['pin'] ?? ''} ",
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'FontMain',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         WidgetSpan(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 8.0),
//                             child: Image.asset(
//                               'assets/images/range.png',
//                               width: 20,
//                               height: 20,
//                             ),
//                           ),
//                         ),
//                         const TextSpan(
//                           text: "",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'FontMain',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Buttons(
//                     onPressed: () {
//                       Get.off(
//                           // () =>
//                           DirectionsPage(
//                             originate: LatLng(
//                               double.parse(45.502807.toString()),
//                               double.parse("-75.786914"),
//                             ),
//                             destinate: LatLng(
//                               double.parse(warehouse['latitude']),
//                               double.parse(warehouse['longitude']),
//                             ),
//                           ),
//                           transition: Transition.fade,
//                           duration: Duration(seconds: 1));

//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => DirectionsPage(
//                       //       destinate: LatLng(
//                       //         double.parse(warehouse['latitude']),
//                       //         double.parse(warehouse['longitude']),
//                       //       ),
//                       //       originate: LatLng(
//                       //         double.parse(45.502807.toString()),
//                       //         double.parse("-75.786914"),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // );
//                     },
//                     title: 'Directions',
//                     height: 45,
//                     width: 150,
//                     colors: const Color(0xffC8EDD9),
//                     textColors: const Color(0xff027335),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Buttons(
//                     onPressed: () {
//                       saveSelectedWareHouse(warehouseMarkerDataInfo[index]);
//                       Get.to(
//                         () => StoreDetail(
//                             storeData: warehouseMarkerDataInfo[index]),
//                         transition: Transition.rightToLeft,
//                       );
//                     },
//                     title: 'View Stores',
//                     height: 45,
//                     width: 250,
//                     colors: const Color(0xff2A6443),
//                     textColors: Colors.white,
//                   ),
//                 ],
//               ),
//               // You can add distance calculation here
//             ],
//           ),
//           // actions: [

//           // ],
//         );
//       },
//     );
//   }

//   double xoffSet = 0;
//   double yoffSet = 0;
//   bool isDrawerOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     // Check if markerIcon is null or not initialized before showing the map
//     if (markerIcon == null) {
//       return const CircularProgressIndicator(); // Or any loading indicator
//     }

//     return SafeArea(
//       child: AnimatedContainer(
//         transform: Matrix4.translationValues(xoffSet, yoffSet, 0)
//           ..scale(isDrawerOpen ? 0.85 : 1.00)
//           ..rotateZ(isDrawerOpen ? -50 : 0),
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(40)),
//         child: Stack(
//           children: [
//             GoogleMap(
//               onMapCreated: (controller) {
//                 mapController = controller;
//               },
//               compassEnabled: true,

//               // initialCameraPosition: const CameraPosition(
//               //   target: LatLng(0, 0),
//               //   zoom: 15,
//               // ),
//               myLocationEnabled: true, // Show user's current location
//               initialCameraPosition: CameraPosition(
//                 target: myLocation,
//                 zoom: 4.0,
//               ),
//               markers: _markers,
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         isDrawerOpen
//                             ? InkWell(
//                                 child: const Card(
//                                   shape: CircleBorder(),
//                                   color: Color(0xff2A6443),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: FaIcon(
//                                       FontAwesomeIcons.xmark,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     xoffSet = 0;
//                                     yoffSet = 0;
//                                     isDrawerOpen = false;
//                                   });
//                                 },
//                               )
//                             : InkWell(
//                                 child: const Card(
//                                   shape: CircleBorder(),
//                                   color: Color(0xff2A6443),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: FaIcon(
//                                       FontAwesomeIcons.bars,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     xoffSet = 360;
//                                     yoffSet = 80;
//                                     isDrawerOpen = true;
//                                   });
//                                 },
//                               ),
//                         InkWell(
//                           child: const Card(
//                             shape: CircleBorder(),
//                             color: Color(0xff2A6443),
//                             child: Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: FaIcon(
//                                 FontAwesomeIcons.solidBell,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           onTap: () {
//                             Get.to(() => const NotificationPage(),
//                                 transition: Transition.rightToLeft);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           onChanged: (value) {
//                             setState(() {
//                               _searchText = value;
//                             });
//                             fetchSuggestions(value);
//                           },
//                           decoration: InputDecoration(
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             hintText: 'Search Location...',
//                             hintStyle: const TextStyle(fontFamily: 'FontMain'),
//                             prefixIcon: const Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(13),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Conditional rendering of suggestions list
//                   if (_searchText.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(13),
//                                   color: Colors.grey[200]),
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: _suggestionsData.length,
//                                 itemBuilder: (context, index) {
//                                   final suggestion = _suggestionsData[index];
//                                   return Column(
//                                     children: [
//                                       ListTile(
//                                         leading: const FaIcon(
//                                           FontAwesomeIcons.solidCircle,
//                                           size: 8,
//                                         ),
//                                         title: Text(
//                                           '${suggestion['name']}',
//                                           style: const TextStyle(
//                                               fontFamily: "Fontmain",
//                                               fontSize: 13),
//                                         ),
//                                         subtitle: Text(
//                                           '${suggestion['address_line_1'] ?? ''} ${suggestion['address_line_2'] ?? ''} ${suggestion['city'] ?? ''} ${suggestion['state'] ?? ''} ${suggestion['pin'] ?? ''}\n${suggestion['phone_no'] ?? ''}',
//                                           style: const TextStyle(
//                                               fontFamily: "Fontmain",
//                                               fontSize: 10),
//                                         ),
//                                         onTap: () {
//                                           // Close the suggestion list
//                                           setState(() {
//                                             _searchText = '';
//                                           });

//                                           // Check if latitude and longitude are available in the suggestion data
//                                           if (suggestion
//                                                   .containsKey('latitude') &&
//                                               suggestion
//                                                   .containsKey('longitude')) {
//                                             double latitude = double.parse(
//                                                 suggestion['latitude']
//                                                     .toString());
//                                             double longitude = double.parse(
//                                                 suggestion['longitude']
//                                                     .toString());

//                                             // Move the camera to the selected location
//                                             mapController.animateCamera(
//                                               CameraUpdate.newLatLngZoom(
//                                                 LatLng(latitude, longitude),
//                                                 15, // Zoom level of 15
//                                               ),
//                                             );
//                                           } else {
//                                             // Handle the case where latitude and/or longitude data is missing
//                                             print(
//                                                 'Latitude and/or longitude data is missing for this suggestion.');
//                                           }
//                                         },
//                                       ),
//                                       const Divider()
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
