import 'package:fintrix/common/custom_textfield.dart';
import 'package:fintrix/screen/home_screen.dart';
import 'package:fintrix/screen/steps.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                labelText: 'Enter Number',
                titleText: 'Enter Your Number',
                controller: numberController,
              ),
              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(labelText: "Enter Name"),
              // ),
              Gap(50),
              ElevatedButton(
                onPressed: () async {
                  await saveName();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text("Continue"),
              ),
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
