import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_responsiveness/experiment.dart';

class FetchView extends StatefulWidget {
  const FetchView({super.key});

  @override
  State<FetchView> createState() => _FetchViewState();
}

class _FetchViewState extends State<FetchView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
          SizedBox(height: 100.h,),
            Center(
              child: Container(
                  height: 120.h,
                  width: 320.w,
                  color: Colors.blue,
              ),
            ),
            SizedBox(height: 50.h,),
            Center(
              child: Container(
                  height: 120.h,
                  width: 320.w,
                  color: Colors.red,
              ),
            ),
             SizedBox(height: 50.h,),
            Center(
              child: Container(
                  height: 120.h,
                  width: 320.w,
                  color: Colors.pink,
              ),
            ),
            ElevatedButton(onPressed: (){
              // ignore: inference_failure_on_instance_creation, lines_longer_than_80_chars
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Experiment(),),);
            }, child: const Text('Next Screen'),),
          ],
        ),
      );
  }
}