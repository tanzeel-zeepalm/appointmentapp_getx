import 'package:appoitment_app/app/data/theme.dart';
import 'package:appoitment_app/app/modules/home/bindings/home_binding.dart';
import 'package:appoitment_app/app/modules/home/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(ScreenUtilInit(
      designSize: const Size(375, 840),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: primaryTheme,
          defaultTransition: Transition.rightToLeft,
          debugShowCheckedModeBanner: false,
          title: 'Hive',
         // initialRoute: AppPages.INITIAL,
          //getPages: AppPages.routes,
          home: SplashScreen(),
          initialBinding: HomeBinding(),
        );
      }));
}
