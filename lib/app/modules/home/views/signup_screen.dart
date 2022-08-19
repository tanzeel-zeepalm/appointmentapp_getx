import 'dart:io';

import 'package:appoitment_app/app/Services/image_services.dart';
import 'package:appoitment_app/app/data/constants.dart';
import 'package:appoitment_app/app/data/typography.dart';
import 'package:appoitment_app/app/modules/home/controllers/auth_controller.dart';
import 'package:appoitment_app/app/modules/home/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
 

  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final _pass = TextEditingController();

   final _name = TextEditingController();
   File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                "Sign In For Appointment",
                style: CustomTextStyle.kmediumTextStyle.copyWith(
                    fontWeight: CustomFontWeight.kExtraBoldFontWeight,
                    color: CustomColor.kdarkblue),
              ),
               SizedBox(
                  height: 20.h,
                ),
                Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundColor: Colors.grey.withOpacity(0.09),
                      child: image != null
                          ? ClipOval(
                              clipBehavior: Clip.antiAlias,
                               
                              child: Image.file(
                                image!,
                                height: 200.h,
                                width: 200.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 50.h,
                              color: Colors.black,
                            ),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: IconButton(
                            onPressed: () async {
                              File? pickedFile = await ImageService().getImage();
                              if (pickedFile != null) {
                                image = pickedFile;
                                setState(() {});
                              }
                            },
                            icon: Icon(Icons.add, color: Colors.white)))
                  ],
                ),
              ),
                Text("UserName",
                  style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kMediumFontWeight,color: CustomColor.kdarkblue ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                        return 'Please Enter your Name';
                      }
                      return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Username",
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text("Email",
                  style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kMediumFontWeight,color: CustomColor.kdarkblue),
                ),
                
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.isEmail) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Email",
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text("Password",
                        style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kMediumFontWeight,color: CustomColor.kdarkblue),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                    controller: _pass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                    )),
                SizedBox(height: 30.h),
                SizedBox(
                    height: 50.h,
                    width: 300.w,
                    child: ElevatedButton(onPressed: () async {
                      if (_formKey.currentState!.validate()) {
      
                    String? imageUrl = await StorageServices().uploadToStorage(image!);
                        
                        // authCont.signup( email: _email.text.trim(), password: _pass.text.trim(), image: imageUrl ?? '',
                        //     name: _name.text.trim()).then((value) => Get.back());
                      }
                    },
                      child: Text("Sign Up",
                        style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kBoldFontWeight,color: CustomColor.kwhite ),
                      ),
      
      
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have Account ? "),
                    SizedBox(
                        width: 10.h
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => LoginPage());
                      },
                      child: Text("Sign In? "),),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
