import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:parcsmart_driver/login_provider/sign_in_page.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  bool isSwitched = false;
  Set<Marker> markers = {};
  late TextEditingController _searchController;
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  @override
  initState() {
    // bool isGranted = true;
    // requestLocation();
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  Future requestLocation() async {
    if (await Permission.locationWhenInUse.isDenied) {
      await Permission.locationWhenInUse.request();
      if (await Permission.locationWhenInUse.request().isGranted) {
        Location location = Location();
        bool isOn = await location.serviceEnabled();
        print('/////////////////////////is on = ///$isOn/////////////////');
        if (!isOn) {
          bool turnedOn = await location.requestService();
          if (turnedOn) {
            print('Location is turned on');
          } else {
            print('Location is turned of');
          }
        }
      } else {
        print(
            '//////////////////////////permission has been denied//////////////////////');
        // Center(
        //   child: SizedBox(
        //     width: 200,
        //     height: 200,
        //     child: AlertDialog(
        //       backgroundColor: Colors.white,
        //       elevation: 5,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(20)),
        //       contentPadding: const EdgeInsets.all(10),
        //       title: const Text('Location Required!'),
        //       content: const Text(
        //           'InOrder to find your Current location, we need access location for this app only when you are using this app'),
        //       actions: [
        //         ElevatedButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //             },
        //             child: const Text('Deny')),
        //         ElevatedButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //               requestLocation();
        //             },
        //             child: const Text('Grant')),
        //       ],
        //     ),
        //   ),
        // );
      }
    } else {
      print('Location Was Granted Previously');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print('/////////////////////////////$width//////////////////////////');
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
      body: Column(
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
                    contentPadding:
                        const EdgeInsets.only(left: 20, bottom: 10, top: 5)),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.009,
          ),
          SizedBox(
            width: width,
            height: height * 0.86,
            child: GoogleMap(
                markers: markers,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
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
              padding: EdgeInsets.only(left: width * 0.1, top: height * 0.003),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: width * 0.78, bottom: height * 0.05),
        child: FloatingActionButton(
          splashColor: Colors.red,
          onPressed: () async {
            Position position = await _getCurrentPosition();
            print('///////////////////$position///////////////////////');
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 17),
            ));
            markers.clear();
            markers.add(Marker(
                markerId: const MarkerId('Current Position'),
                position: LatLng(position.latitude, position.longitude)));
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
      Location location = Location();
      await location.requestService();
      // return Future.error('Location services are disabled');
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
}
