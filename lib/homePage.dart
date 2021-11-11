import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';

const apiKey="f88c92e65f9d5f6c41645219e396555b974f23bc9810b453d4b6df622ffdca4f3134bd3919b87983";
class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
List FilterNames=['None', 'Glasses', 'Oval Face', 'Dog', 'Animal', 'Shrink', 'Fox', 'Multiface'];
class _HomePageState extends State<HomePage> {
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  print("Camera status $isReady");
                },
                onImageCaptured: (path) {
                  print("Image Taken $path");
                },
                onVideoRecorded: (path) {
                  print("Video Recorded @ $path");
                },
                //Enter the App key generate from Deep AR
                androidLicenceKey:apiKey,
                iosLicenceKey:apiKey,
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:20.0),
                      child: FloatingActionButton(
                        child: Icon(Icons.camera),
                        backgroundColor: Colors.indigo,
                        onPressed: (){
                          cameraDeepArController.snapPhoto();
                        }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: List.generate(8, (p) {
                              bool active = currentPage == p;
                              return GestureDetector(
                                onTap: () {
                                  currentPage = p;
                                  cameraDeepArController.changeMask(p);
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      width: active ? 60 : 50,
                                      height: active ? 70 : 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                          active ? Colors.deepPurple : Colors.deepPurple[50],
                                          shape: BoxShape.circle),
                                      child: Text(
                                        "$p",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: active ? 16 : 14,
                                          color: active? Colors.white : Colors.black, fontWeight: FontWeight.w800
                                        ),
                                      )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Text(FilterNames[p], 
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: active ? 16 : 14,
                                        color: Colors.black, 
                                        backgroundColor: Colors.white,
                                        fontWeight: active? FontWeight.w800: FontWeight.normal
                                      ),),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}