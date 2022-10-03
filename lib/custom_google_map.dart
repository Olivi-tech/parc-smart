import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parcsmart_driver/login_provider/sign_in_page.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);
  static const LatLng _kMapCenter =
      LatLng(19.018255973653343, 72.84793849278007);
  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);
  static final Completer<GoogleMapController> _controller = Completer();

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  bool isSwitched = false;
  late TextEditingController _searchController;

  @override
  void initState() {
    // TODO: implement initState
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
            height: height * 0.8,
            child: GoogleMap(
              initialCameraPosition: CustomGoogleMap._kInitialPosition,
              myLocationButtonEnabled: true,
              indoorViewEnabled: true,
              // mapType: MapType.hybrid,
              onMapCreated: (GoogleMapController controller) {
                CustomGoogleMap._controller.complete(controller);
              },
            ),
          ),
          Container(
            width: width,
            height: height * 0.05,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.1, top: height * 0.012),
              child: const Text(
                'Can\'t find or park? Login to request assistance ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.06,
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
    );
  }
}
