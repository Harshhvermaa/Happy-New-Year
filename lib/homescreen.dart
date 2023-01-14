import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'adsController/adscontroller.dart';
import 'postmaking.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> {
  //  BannerAd? bannerAd2;
  bool? isLoaded;
  XFile? xFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adController().createBannerAd();
    adController().createBannerAd4();
    adController().createInterstitial();
    // _createBannerAd2();
  }

  // _createBannerAd2() {
  //   bannerAd2 = BannerAd(
  //     size: AdSize.fullBanner,
  //     adUnitId: bannerunitId2,
  //     listener: bannerAdListener,
  //     request: const AdRequest(),
  //   )..load();
  // }
  getImage(ImageSource source) async {
    xFile = await _picker.pickImage(source: source);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    print("$height ddsfdsf");
    print("$width dfsdfsdf ");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 59, 72),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 52.h,
            child: AdWidget(ad: bannerAd4!),
          ),
          SizedBox(
            height: 82.h,
          ),
          // Happy
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Image.asset("assets/happy.png"),
              ),

              SizedBox(
                height: 10.h,
              ),
              // New Year
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Image.asset("assets/ny.png"),
              ),

              SizedBox(
                height: 10.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Image.asset("assets/2020.png"),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 120.h,
              ),

              Text(
                "Please choose Image" ,
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30.0.sp,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 25.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 70.h,
                  child: ElevatedButton(
                      onPressed: () async {
                        await adController().showInterstitialAD();
                        await getImage(ImageSource.camera);
                        xFile != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return postMakingScreen(
                                      xfile: xFile!,
                                    );
                                  },
                                ),
                              )
                            : adController().showInterstitialAD();
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(12.0.w),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      child: Text(
                        "Camera",
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 30.0.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),

              SizedBox(
                height: 40.h,
              ),
              // Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 70.h,
                  child: ElevatedButton(
                      onPressed: () async {
                        print("object");
                        adController().showInterstitialAD();
                        await getImage(ImageSource.gallery);
                        xFile != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return postMakingScreen(
                                      xfile: xFile!,
                                    );
                                  },
                                ),
                              )
                            : adController().showInterstitialAD();
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(12.0.w),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      child: Text(
                        "Gallery",
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 30.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                  ),
                ),
              ),
            ],
          ),
          // const Spacer(),
          SizedBox(
            height: 130.h,
          ),
          const Spacer(),
          SizedBox(
            height: 52.h,
            child: AdWidget(ad: bannerAd!),
          )
        ],
      ),
    );
  }
}
