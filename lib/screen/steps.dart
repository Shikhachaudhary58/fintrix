// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:fintrix/screen/address_screen.dart';
// import 'package:fintrix/screen/first_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class StepsScreen extends StatelessWidget {
//   const StepsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AnimatedSplashScreen(
//           splash: Column(
//             children: [
//               Expanded(
//                 child: LottieBuilder.asset("assets/lottie/hello_animation.json"),
//               ),
//             ],
//           ),
//           nextScreen: FirstScreen(),
//           splashIconSize: 200,
//           backgroundColor: Colors.blue.shade50,
//         ),

//       ],
//     );
//   }
// }

// import 'package:fintrix/screen/first_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// class StepsScreen extends StatefulWidget {
//   const StepsScreen({super.key});

//   @override
//   State<StepsScreen> createState() => _StepsScreenState();
// }

// class _StepsScreenState extends State<StepsScreen> {
//   final PageController _controller = PageController();
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade50,
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _controller,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentIndex = index;
//                 });
//               },
//               children: [
//                 _buildPage("assets/lottie/hello_animation.json"),
//                 _buildPage("assets/lottie/hello_animation.json"),
//                 _buildPage("assets/lottie/hello_animation.json"),
//               ],
//             ),
//           ),

//           /// 🔹 Animated Dots Indicator
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               3,
//               (index) => AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 margin: const EdgeInsets.symmetric(horizontal: 5),
//                 height: 10,
//                 width: currentIndex == index ? 25 : 10,
//                 decoration: BoxDecoration(
//                   color: currentIndex == index
//                       ? Colors.blue
//                       : Colors.grey.shade400,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 40),

//           /// 🔹 Next Button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: ElevatedButton(
//               onPressed: () {
//                 if (currentIndex == 2) {
//                   Get.offAll(() => const FirstScreen());
//                 } else {
//                   _controller.nextPage(
//                     duration: const Duration(milliseconds: 400),
//                     curve: Curves.easeInOut,
//                   );
//                 }
//               },
//               child: Text(currentIndex == 2 ? "Get Started" : "Next"),
//             ),
//           ),

//           const SizedBox(height: 50),
//         ],
//       ),
//     );
//   }

//   Widget _buildPage(String asset) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Lottie.asset(asset),
//     );
//   }
// }

import 'package:fintrix/screen/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  final List<String> pageTitles = ["Discover", "Messaging", "Voice Recording"];

  void nextPage() {
    if (currentIndex == 2) {
      // Last page → Go to AddressScreen
      Get.to(() => AddressScreen());
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    Get.to(() => AddressScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                pageTitles[currentIndex],
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade600,
                ),
              ),
            ),

            /// 🔹 PageView Section
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: [
                  _buildPage(
                    "assets/lottie/location.json",

                    'First you have to add your location',
                    'Add your location to get nearby help',
                    Colors.deepPurple.shade400,
                  ),
                  _buildPage(
                    "assets/lottie/messaging.json",
                    'You can raise your query by typing',
                    //  'You can raise your query by typing',
                    "Send Your Queries Easily",
                    Colors.deepPurpleAccent.shade400,
                  ),
                  _buildPage(
                    "assets/lottie/voicerecoed.json",
                    'You can raise your query by voice recording',
                    "Speak Instead of Typing",
                    Colors.orangeAccent.shade400,
                  ),
                ],
              ),
            ),

            /// 🔹 Animated Dot Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: currentIndex == index ? 25 : 10,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.blueAccent.shade700
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// 🔹 Buttons Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: currentIndex == 2
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: [
                  /// Skip Button (only on first & second page)
                  if (currentIndex != 2)
                    TextButton(
                      onPressed: skip,
                      child: const Text("Skip", style: TextStyle(fontSize: 16)),
                    ),

                  ElevatedButton(
                    onPressed: nextPage,
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    String asset,
    String text,
    String title,
    Color containerColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Center(child: Text('Location')),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 500,
                height: 480,
                decoration: BoxDecoration(
                  // color: Colors.deepPurple.shade400,
                  color: containerColor,
                  borderRadius: BorderRadius.circular(80),
                  // shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: -30,
                left: 10,
                right: 10,
                child: Container(
                  width: Get.width * 0.9,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(80),
                    // shape: BoxShape.circle,
                  ),
                  child: Lottie.asset(asset, fit: BoxFit.contain),
                ),
              ),
              Positioned(
                // top: 220,
                bottom: 70,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Gap(20),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Expanded(flex: 5, child: Lottie.asset(asset)),
          // Gap(10),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     text,
          //     style: const TextStyle(
          //       fontFamily: 'Gilroy',
          //       fontSize: 14,
          //       fontWeight: FontWeight.w600,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
