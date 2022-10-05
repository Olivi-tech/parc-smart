import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parcsmart_driver/login_provider/sign_in_page.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  var uuid = const Uuid();
  String? sessionToken;
  List<dynamic> placesList = [];
  bool isSwitched = false;
  late TextEditingController _searchController;
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(14.6824, -17.4408), zoom: 14);

  @override
  initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      if (sessionToken == null) {
        setState(() {
          sessionToken = uuid.v4();
        });
      } else {
        getSuggestions(_searchController.text);
      }
    });
    buildMarker();
  }

  void getSuggestions(String input) async {
    const kGoogleApiKey = 'AIzaSyCuPO4QpbmH7zZ3Q-FmyBfQMZQjC0I5vns';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kGoogleApiKey&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print(
          '///////////////////${response.body.toString()}/////////////////////////');
      setState(() {
        placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  bool isLoading = true;
  var icon;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  // Future requestLocation() async {
  //   if (await Permission.locationWhenInUse.isDenied) {
  //     await Permission.locationWhenInUse.request();
  //     if (await Permission.locationWhenInUse.request().isGranted) {
  //       Location location = Location();
  //       bool isOn = await location.serviceEnabled();
  //       print('/////////////////////////is on = ///$isOn/////////////////');
  //       if (!isOn) {
  //         bool turnedOn = await location.requestService();
  //         if (turnedOn) {
  //           print('Location is turned on');
  //         } else {
  //           print('Location is turned of');
  //         }
  //       }
  //     } else {
  //       print(
  //           '//////////////////////////permission has been denied//////////////////////');
  //       // Center(
  //       //   child: SizedBox(
  //       //     width: 200,
  //       //     height: 200,
  //       //     child: AlertDialog(
  //       //       backgroundColor: Colors.white,
  //       //       elevation: 5,
  //       //       shape: RoundedRectangleBorder(
  //       //           borderRadius: BorderRadius.circular(20)),
  //       //       contentPadding: const EdgeInsets.all(10),
  //       //       title: const Text('Location Required!'),
  //       //       content: const Text(
  //       //           'InOrder to find your Current location, we need access location for this app only when you are using this app'),
  //       //       actions: [
  //       //         ElevatedButton(
  //       //             onPressed: () {
  //       //               Navigator.pop(context);
  //       //             },
  //       //             child: const Text('Deny')),
  //       //         ElevatedButton(
  //       //             onPressed: () {
  //       //               Navigator.pop(context);
  //       //               requestLocation();
  //       //             },
  //       //             child: const Text('Grant')),
  //       //       ],
  //       //     ),
  //       //   ),
  //       // );
  //     }
  //   } else {
  //     print('Location Was Granted Previously');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(
        '//////////////////isLoading///////////$isLoading//////////////////////////');
    double height = MediaQuery.of(context).size.height - 84;
    return Scaffold(
      backgroundColor: Colors.teal,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Available Parking'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignIn()));
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  width: width,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              _searchController.clear();
                            },
                            icon: Icon(_searchController.text.isNotEmpty
                                ? Icons.clear
                                : null)),
                        hintText: 'Search Available Parking',
                        hintStyle: const TextStyle(fontSize: 16),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 20, bottom: 10, top: 5)),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.009,
              ),
              SizedBox(
                width: width,
                height: height * 0.86,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.redAccent,
                        backgroundColor: Colors.white,
                      ))
                    : GoogleMap(
                        markers: {
                            Marker(
                                markerId: const MarkerId('0'),
                                icon: BitmapDescriptor.fromBytes(icon),
                                position: const LatLng(14.6824, -17.4408),
                                infoWindow:
                                    const InfoWindow(title: 'PARC SMART')),
                            Marker(
                                markerId: const MarkerId('0'),
                                icon: BitmapDescriptor.fromBytes(icon),
                                position: const LatLng(14.6826, -17.4404),
                                infoWindow: const InfoWindow(
                                    title: '1 - CENTRAL PARK')),
                            Marker(
                                markerId: const MarkerId('0'),
                                icon: BitmapDescriptor.fromBytes(icon),
                                position: const LatLng(14.6824, -17.44),
                                infoWindow: const InfoWindow(
                                    title: '3 - CPK VISITEUR')),
                          },
                        myLocationEnabled: true,
                        initialCameraPosition: initialCameraPosition,
                        myLocationButtonEnabled: false,
                        indoorViewEnabled: true,
                        // mapType: MapType.hybrid,
                        onMapCreated: (GoogleMapController controller) {
                          googleMapController = controller;
                        }),
              ),
              Container(
                width: width,
                height: height * 0.03,
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.1, top: height * 0.003),
                  child: const Text(
                    'Can\'t find or park? Login to request assistance ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.green,
                height: height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Covered',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          isSwitched = value;
                        }),
                    const Text(
                      'Paved',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          isSwitched = value;
                        }),
                    const Text(
                      'CarWash',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        }),
                  ],
                ),
              )
            ],
          ),
          _searchController.text.isEmpty
              ? const SizedBox(
                  width: 0,
                  height: 0,
                )
              : Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Container(
                    color: Colors.white,
                    width: width,
                    height: height * 0.6,
                    child: ListView.builder(
                        itemCount: placesList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            //     tileColor: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onTap: () async {
                              _searchController.text =
                                  placesList[index]['description'];
                              print(
                                  '_searchController.text ==${_searchController.text}/////////');

                              Position position =
                                  await Geolocator.getCurrentPosition();
                              List<Location> locations =
                                  await locationFromAddress(
                                      placesList[index]['description']);
                              googleMapController
                                  .animateCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(
                                    target: LatLng(locations.last.latitude,
                                        locations.last.longitude),
                                    zoom: 14),
                              ));

                              print('/////longitude${locations.last.longitude}'
                                  'latitude///////${locations.last.latitude}');
                            },
                            title: Text(placesList[index]['description']),
                          );
                        }),
                  ),
                ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: width * 0.78, bottom: height * 0.05),
        child: FloatingActionButton(
          splashColor: Colors.red,
          onPressed: () async {
            Position position = await _getCurrentPosition();
            print(
                '//////////currentPosition////////$position///////////////////////');
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 17),
            ));
            // markers.clear();
            // markers.add(Marker(
            //     markerId: const MarkerId('Current Position'),
            //     position: LatLng(position.latitude, position.longitude)));
            setState(() {});
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error('Location is disabled');
      // Geolocator.openLocationSettings();
      // showDialog(
      //     context: context,
      //     builder: (context) => Center(
      //             child: Container(
      //           width: 300,
      //           color: Colors.white,
      //           height: 300,
      //           child: Column(
      //             children: [
      //               Text('Location is Disabled'),
      //               SizedBox(height: 20),
      //               Row(
      //                 children: [
      //                   ElevatedButton(
      //                       onPressed: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: Text('Deny')),
      //                   ElevatedButton(
      //                       onPressed: () {
      //
      //                       },
      //                       child: Text('Allow')),
      //                 ],
      //               )
      //             ],
      //           ),
      //         )));
      // Location location = Location();
      // await location.requestService();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error('Location Permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Future.error('Location permissions are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width, required int height}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: height, targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  buildMarker() async {
    icon = await getBytesFromAsset(
        path: 'assets/images/markerImg.png', height: 100, width: 200);
    setState(() {
      isLoading = false;
    });
  }
}
