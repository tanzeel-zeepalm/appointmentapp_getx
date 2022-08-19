
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:appoitment_app/app/data/constants.dart';
import 'package:appoitment_app/app/data/typography.dart';
import 'package:appoitment_app/app/modules/home/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
// ignore: depend_on_referenced_packages
import "package:page_transition/page_transition.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: Text("Appointment App",
                style: CustomTextStyle.kLargeStyle.copyWith(fontWeight: CustomFontWeight.kExtraBoldFontWeight,color: CustomColor.kdarkblue ),
              ),
      splashIconSize: 250.h,
      duration: 3000,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      nextScreen: LoginPage(),
      animationDuration: const Duration(seconds: 1),
    );
  }
}
