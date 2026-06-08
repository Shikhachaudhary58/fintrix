// import 'package:fintrix/common/custom_button.dart';
// import 'package:fintrix/screen/address_screen.dart';
// import 'package:fintrix/screen/steps.dart';
// import 'package:fintrix/screen/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class FirstScreen extends StatefulWidget {
//   const FirstScreen({super.key});

//   @override
//   State<FirstScreen> createState() => _FirstScreenState();
// }

// class _FirstScreenState extends State<FirstScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: InkWell(
//           onTap: () => Get.to(() => StepsScreen()),
//           // Get.to((AddressScreen())),
//           child: Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.black,
//             ),
//             child: Center(child: Icon(Icons.add, color: Colors.white)),
//           ),
//         ),
//         // customButton(
//         //   title: 'Start',
//         //   onTap: () => Get.to((AddressScreen())),
//         // ),
//       ),
//     );
//   }
// }

import 'package:fintrix/screen/steps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// Center Lottie Animation
      body: Center(
        child: SizedBox(
          width: 250,
          child: Lottie.asset(
            'assets/lottie/waving_man.json', // apna lottie path yaha daalo
            fit: BoxFit.contain,
          ),
        ),
      ),

      /// Floating Button Bottom Right
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () {},
        // => Get.to(() => StepsScreen()),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
