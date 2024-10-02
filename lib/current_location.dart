import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_responsiveness/logs.dart';
//import 'package:lazeez_application/configuration/logs.dart';


// class FetchCurrentLocation {
//   FetchCurrentLocation(this.updateLocation);

//   String? latitude;
//   String? longitude;
//   String? address;

//   final Function(String lat, String long, String addr) updateLocation;

//   Future<void> getCurrentLocation(BuildContext context) async {
//     final permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       logs('Location Denied');
//       await showPermissionModal(context); // Show modal to ask for permission
//     } else {
//       final currentPosition = await Geolocator.getCurrentPosition();
//       logs('Latitude = ${currentPosition.latitude}');
//       logs('Longitude = ${currentPosition.longitude}');
//       latitude = currentPosition.latitude.toString();
//       longitude = currentPosition.longitude.toString();
//       await getAddress(currentPosition.latitude, currentPosition.longitude);
//     }
//   }

//   Future<void> getAddress(double lat, double long) async {
//     final placemarks = await placemarkFromCoordinates(lat, long);
//     address = '${placemarks[0].street}, ${placemarks[0].country}';
//     updateLocation(latitude!, longitude!, address!);

//     for (var i = 0; i < placemarks.length; i++) {
//       logs('Index of $i: ${placemarks[i]}');
//     }
//   }

//   Future<void> showPermissionModal(BuildContext context) async {
//     await showModalBottomSheet(
//       context: context,
//       isDismissible: false, // Prevent dismissing the modal by tapping outside
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => false, // Prevent back button dismiss
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Location Permission Required',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'This app needs location access to function properly. Please allow location access.',
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await Geolocator.requestPermission();
//                     Navigator.of(context).pop(); // Close the modal
//                   },
//                   child: const Text('Allow'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class CurrentLocation extends StatefulWidget {
//   @override
//   _CurrentLocationState createState() => _CurrentLocationState();
// }

// class _CurrentLocationState extends State<CurrentLocation> {
//   String? latitude;
//   String? longitude;
//   String? address;

//   Future<void> getCurrentLocation() async {
//     final permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       logs('Location Denied');
//       await showPermissionModal(); // Show modal if permission is denied
//     } else {
//       final currentPosition = await Geolocator.getCurrentPosition();
//       logs('Latitude = ${currentPosition.latitude}');
//       logs('Longitude = ${currentPosition.longitude}');
//       setState(() {
//         latitude = currentPosition.latitude.toString();
//         longitude = currentPosition.longitude.toString();
//       });
//       await getAddress(currentPosition.latitude, currentPosition.longitude);
//     }
//   }

//   Future<void> getAddress(double lat, double long) async {
//     final placemarks = await placemarkFromCoordinates(lat, long);
//     setState(() {
//       address = '${placemarks[0].street}, ${placemarks[0].country}';
//     });

//     for (var i = 0; i < placemarks.length; i++) {
//       logs('Index of $i: ${placemarks[i]}');
//     }
//   }

//   Future<void> showPermissionModal() async {
//     await showModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => false, // Prevent back button dismiss
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Location Permission Required',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'This app needs location access to function properly. Please allow location access.',
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await Geolocator.requestPermission();
//                     Navigator.of(context).pop(); // Close the modal
//                   },
//                   child: const Text('Allow'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         title: const Text('Geolocator'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: getCurrentLocation,
//               child: const Text('Get Location'),
//             ),
//           ),
//           if (latitude != null && longitude != null)
//             Column(
//               children: [
//                 Text('Latitude: $latitude'),
//                 Text('Longitude: $longitude'),
//                 if (address != null)
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Text('Address: $address'),
//                   ),
//               ],
//             )
//           else
//             const Text('No location available'),
//         ],
//       ),
//     );
//   }
// }
//import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as realLocation;
import 'package:gif/gif.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _isLoading = false;
  IconData? _locationIconData;
  Color? _locationIconColor;
  realLocation.LocationData? _currentLocation;
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      _showLocationPermissionSheet();
    } else {
      _updateLocation();
    }
  }

  void _showLocationPermissionSheet() {
    // ignore: inference_failure_on_function_invocation
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 230,
                    child: Gif(
                      autostart: Autostart.once,
                      placeholder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                      image:  const NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.textstudio.com%2Fword-logos%2Fanimated%2Flocation-15587&psig=AOvVaw2OaaX2DOHqwAJGZAARytmG&ust=1727941314849000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCKCOsZaZ74gDFQAAAAAdAAAAABAX')
                      // const AssetImage('assets/images/location.gif'),
                    ),
                  ),
                  const Text(
                    'Location Permission Required',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Grant location permission to use the app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the modal sheet
                        _requestLocationPermission();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 24),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Grant Permission',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _updateLocation();
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

  void _showSettingsDialog() {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
            'To enable location services, please go to the app settings and enable location permission.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateLocation() async {
    setState(() {
      _isLoading = true;
    });
    var location = realLocation.Location();
    var status = await Permission.location.status;
    if (status.isGranted) {
      try {
        location.changeSettings(accuracy: realLocation.LocationAccuracy.high);
        _currentLocation = await location.getLocation();
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        );
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          String address = '${placemark.street ?? ''}, '
              '${placemark.subLocality ?? ''}, '
              '${placemark.locality ?? ''}, '
              '${placemark.administrativeArea ?? ''}, '
              '${placemark.postalCode ?? ''}';
          setState(() {
            locationController.text = address.isNotEmpty ? address : 'Unknown location';
            _locationIconData = Icons.location_on;
            _locationIconColor = Colors.green;
          });
        } else {
          setState(() {
            locationController.text = 'Unknown location';
            _locationIconData = Icons.location_on;
            _locationIconColor = Colors.green;
          });
        }
      } catch (e) {
        setState(() {
          locationController.text = 'Error fetching location';
          _locationIconData = Icons.location_off;
          _locationIconColor = Colors.red;
        });
      }
    } else {
      setState(() {
        _locationIconData = Icons.location_off;
        _locationIconColor = Colors.red;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Permission Example'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _locationIconData ?? Icons.location_off,
                    size: 50,
                    color: _locationIconColor ?? Colors.red,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: locationController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Your Location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
