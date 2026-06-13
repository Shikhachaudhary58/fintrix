import 'package:fintrix/common/custom_button.dart';
import 'package:fintrix/common/custom_textfield.dart';
import 'package:fintrix/screen/home_screen.dart';
import 'package:fintrix/screen/steps.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", nameController.text);
    await prefs.setString('phone', numberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade700,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
                // color: Colors.purple.shade300,
              ),
              Positioned(
                top: 60,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Enter your details to continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [

                    //   ],
                    // ),
                  ],
                ),
              ),
              Positioned(
                top: 110,
                right: -30,
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Lottie.asset(
                    'assets/lottie/hello_animation.json', // apna lottie path yaha daalo
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          Gap(50),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonTextFieldWithLabel(
                  labelText: 'Enter Name',
                  titleText: 'Enter Your Name',
                  controller: nameController,
                ),
                Gap(10),
                CommonTextFieldWithLabel(
                  labelText: 'Enter Registered Number',
                  titleText: 'Enter Your Number',
                  controller: numberController,
                ),
                // TextField(
                //   controller: nameController,
                //   decoration: InputDecoration(labelText: "Enter Name"),
                // ),
                Gap(10),
                CommonTextFieldWithLabel(
                  obscureText: !isPasswordVisible,
                  labelText: 'Enter Password',
                  titleText: 'Password',
                  controller: passwordController,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                Gap(50),
                customButton(
                  bgColor: Colors.purple,
                  title: 'Continue',
                  onTap: () async {
                    await saveName();
                    Get.to(() => HomeScreen());
                  },
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     await saveName();
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HomeScreen()),
                //     );
                //   },
                //   child: Text("Continue"),
                // ),
              ],
            ).paddingSymmetric(horizontal: 20, vertical: 10),
          ),
        ],
      ),
    );
  }
}
