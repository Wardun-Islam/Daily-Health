import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_place/google_place.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';

void main() => runApp(NearbyhospitalScreen());

class NearbyhospitalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: SafeArea(
        child: MapSample(),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  LatLng latlong = null;
  CameraPosition _cameraPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initstate");
    getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _markers,
            ),
          ],
        ),
      ),
    );
  }

  getLocations(LatLng latlong) async {
    //var googlePlace = GooglePlace("AIzaSyA1stulAGuFxu7LY6_9t4E8UgWv92GTC3Q");
    //var result = await googlePlace.search.getNearBySearch(
    //    Location(lat: latlong.latitude, lng: latlong.longitude), 1500,
    //    keyword: "hospital");
    //print(latlong);
    //print("hospitals");
    //print(result.status);
    //print(result.results);
    //print(result.hashCode);
    //23.8104 90.431
    var locations = [];
    final String postsURL =
        "https://places.ls.hereapi.com/places/v1/autosuggest?q=hopital&in=${latlong.latitude},${latlong.longitude};r=15000&cs=places&app_id=uy0jzBVKIQxrBek3BBqK&app_code=y0CqqNVqdpsepe-Zaoc3xw";

    await get(Uri.parse(postsURL)).then((response) {
      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        List<dynamic> entitlements = jsonResponse["results"];
        entitlements.forEach((entitlement) {
          print(entitlement["title"]);
          //print(entitlement["position"][0]);
          //print(entitlement["position"][1]);
          if (entitlement["position"] != null) {
            locations.add({
              'latlang': new LatLng(
                  entitlement["position"][0], entitlement["position"][1]),
              'name': entitlement["title"]
            });
          }
        });
        setState(() {
          for (var location in locations) {
            _markers.add(
              Marker(
                markerId: MarkerId(location['name']),
                draggable: false,
                position: location['latlang'],
                infoWindow: InfoWindow(
                  title: location['name'],
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
              ),
            );
          }
        });
        // print("jsonResponse");
        // print(jsonResponse["results"]);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });

    // locations.add(
    //     {'latlang': new LatLng(23.8104, 90.431), 'name': "Evercare_Hospital"});
    // locations.add({
    //   'latlang': new LatLng(
    //     23.825698524570342,
    //     90.37329912274717,
    //   ),
    //   'name': "CMH Hospital, Dhaka Cantonment"
    // });
    // locations.add({
    //   'latlang': new LatLng(23.806470476471347, 90.4170191278905),
    //   'name': "United Hospital Limited"
    // });
    // locations.add({
    //   'latlang': new LatLng(23.8227781057091, 90.4089174111838),
    //   'name': "Kurmitola General Hospital"
    // });
    // locations.add({
    //   'latlang': new LatLng(23.8032372891709, 90.42689730191597),
    //   'name': "Stroke & Neuro Rehab Clinic | Senior Citizen Hospital"
    // });
    // locations.add({
    //   'latlang': new LatLng(23.792408347954517, 90.39505720098425),
    //   'name': "BANGKOK HOSPITAL OFFICE BANGLADESH"
    // });
    // locations.add({
    //   'latlang': new LatLng(23.786894441893626, 90.4189389262881),
    //   'name': "Badda General Hospital Pvt. Ltd."
    // });
  }

  Future getCurrentLocation() async {
    print("getCurrentLocation");
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    permission = await Geolocator.requestPermission();
    print(permission);
    getLocation();
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Position" + position.latitude.toString());
    setState(() {
      latlong = new LatLng(position.latitude, position.longitude);
      _cameraPosition = CameraPosition(target: latlong, zoom: 14);
      if (_controller != null)
        _controller
            .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

      _markers.add(Marker(
          markerId: MarkerId("a"),
          draggable: false,
          position: latlong,
          infoWindow: InfoWindow(
            title: "My Location",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          onDragEnd: (_currentlatLng) {
            latlong = _currentlatLng;
          }));
    });
    getLocations(latlong);
  }

  Future<String> getCurrentAddress() async {
    final coordinates = new Coordinates(latlong.latitude, latlong.longitude);
    var results =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = results.first;
    if (first != null) {
      print(first.featureName);
      return first.featureName;
    }
    return "";
  }
}
