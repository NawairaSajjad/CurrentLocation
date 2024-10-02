import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_responsiveness/current_location.dart';
import 'package:screen_responsiveness/experiment.dart';
import 'package:screen_responsiveness/view.dart';
void main(){
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(375, 812),
       minTextAdapt: true,
       builder: (context, child){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Experiment(),
        //  LocationPage(),
        // const Experiment(),
      );
       },
    );
    
    
  }
}
