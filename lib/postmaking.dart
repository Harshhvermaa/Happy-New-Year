import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'adsController/adscontroller.dart';
import 'frames/frames.dart';

class postMakingScreen extends StatefulWidget {
  XFile? xfile;
  postMakingScreen({required this.xfile});

  @override
  State<postMakingScreen> createState() => postMakingScreenState();
}

class postMakingScreenState extends State<postMakingScreen> {
  double left = 0.0.w;
  double right = 0.0.w;
  double top = 0.0.h;
  double bottom = 0.0.h;

  bool isEditpressed = false;

  List<String> frames = Constantt().frames;
  Image? _image;
  String _currentFrame = "assets/8.png";

  pressed() {
    setState(() {
      isEditpressed ? isEditpressed = false : isEditpressed = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adController().createBannerAd2();
    adController().createBannerAd3();
    adController().createInterstitial();
    adController().createInterstitial2();
    // adController().createBannerAd3();
  }

  GlobalKey previewContainer = GlobalKey();
  int originalSize = 800;

  @override
  Widget build(BuildContext context) {
    print(isEditpressed);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 58, 68),
        title: Text(
          "Let's create",
          style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 59, 72),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          bannerAd3 != null
              ? SizedBox(
                  height: 55.h,
                  child: AdWidget(ad: bannerAd2!),
                )
              : const SizedBox(),
          bannerAd2 != null
              ? SizedBox(
                  height: 55.h,
                  child: AdWidget(ad: bannerAd3!),
                )
              : const SizedBox(),
          RepaintBoundary(
            key: previewContainer,
            child: SizedBox(
              height: 500.h,
              width: double.maxFinite,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      print("object");
                    },
                    child: Positioned(
                      left: left,
                      right: right,
                      bottom: bottom,
                      top: top,
                      child: SizedBox(
                        height: 500.h,
                        width: double.infinity,
                        child:InteractiveViewer(
                          panEnabled: true,
                          alignPanAxis: true,
                          scaleEnabled: true,
                          boundaryMargin: EdgeInsets.all(100),
                          minScale: 0.5,
                          maxScale: 2,
                          child: Image.file(
                              File(widget.xfile!.path.toString()),
                      ),
                        ),
                    ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: GestureDetector(
                      onTap: (){
                        print("object2");
                      },
                      child: SizedBox(
                        height: 500.h,
                        width: double.infinity,
                        child: Image.asset(
                          _currentFrame,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200.w,
                height: 60.h,
                child: ElevatedButton(
                    onPressed: () {
                      adController().showInterstitialAD2();
                      isEditpressed == true ? pressed() : pressed();
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(12.0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 255, 128, 74)),
                    ),
                    child: Text(
                      isEditpressed == false ? "Edit" : "Done",
                      style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30.0.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                width: 200.w,
                height: 60.h,
                child: ElevatedButton(
                    onPressed: () async {
                      await adController().createInterstitial2();
                      ShareFilesAndScreenshotWidgets().shareScreenshot(
                          previewContainer,
                          originalSize,
                          "Title",
                          "Name.png",
                          "image/png",
                          text: "");
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(12.0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 255, 128, 74)),
                    ),
                    child: Text(
                      "Save",
                      style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30.0.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          isEditpressed == true
              ? Container(
                  height: 200.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  bottom += 10.w;
                                  top -= 10.h;
                                });
                                print(
                                    "top: $top,left : $left,right : $right,bottom : $bottom");
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(12.0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 255, 128, 74)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text("Top"),
                              )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 120.w,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      right += 10.w;
                                      left -= 10.w;
                                    });
                                    print(
                                        "top: $top,left : $left,right : $right,bottom : $bottom");
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(12.0),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 128, 74)),
                                  ),
                                  child: const Text("Left")),
                            ),
                            SizedBox(
                              width: 120.h,
                              child: ElevatedButton(
                                  onPressed: () {
                                    adController().showInterstitialAD2();
                                    setState(() {
                                      left = 0.0.w;
                                      right = 0.0.w;
                                      top = 0.0.h;
                                      bottom = 0.0.h;
                                    });
                                    print(
                                        "top: $top,left : $left,right : $right,bottom : $bottom");
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(12.0),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 128, 74)),
                                  ),
                                  child: const Text("Reset")),
                            ),
                            SizedBox(
                              width: 120.h,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      left += 10.w;
                                      right -= 10.w;
                                    });
                                    print(
                                        "top: $top,left : $left,right : $right,bottom : $bottom");
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(12.0),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 128, 74)),
                                  ),
                                  child: const Text("Right")),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  top += 10.h;
                                  bottom -= 10.h;
                                });
                                print(
                                    "top: $top,left : $left,right : $right,bottom : $bottom");
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(12.0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 255, 128, 74)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text("Bottom"),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    itemCount: frames.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentFrame = frames[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsetsDirectional.only(end: 10.w),
                          height: 150.h,
                          width: 150.w,
                          color: const Color.fromARGB(255, 255, 252, 252),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              frames[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
