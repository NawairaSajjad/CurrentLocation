import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_responsiveness/current_location.dart';
import 'package:screen_responsiveness/main.dart';

class Experiment extends StatefulWidget {
  const Experiment({super.key});

  @override
  State<Experiment> createState() => _ExperimentState();
}

class _ExperimentState extends State<Experiment> {
   String? latitude;
  String? longitude;
  String? address;

void initState() {
    super.initState();
    
    //  FetchCurrentLocation((lat, long, addr) {
    //   setState(() {
    //     latitude = lat;
    //     longitude = long;
    //     address = addr;
    //   });
    // }).getCurrentLocation(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50.h,),
           Center(
             child: Text('Test the responsiveness of screen',style: TextStyle(
              fontSize: 24.sp,
             
                       ),),
           ),
          //  Text(address ?? 'Fetching address...'),

        ],
      ),
    );
  }
}