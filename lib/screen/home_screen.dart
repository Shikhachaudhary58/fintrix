import "package:fintrix/screen/steps.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:get/get.dart";
import "package:get/get_core/src/get_main.dart";
import "package:lottie/lottie.dart";
import "package:shared_preferences/shared_preferences.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "User";
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // height: Get.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade700,
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(60),
              //   bottomRight: Radius.circular(60),
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$username",
                    // "Do you have any query?",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
            // color: Colors.purple.shade300,
          ),
          // Positioned(
          //   top: 60,
          //   left: 20,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "Hi, $username",
          //         style: TextStyle(
          //           fontSize: 40,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //       Text(
          //         "Do you have any query?",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //       // Row(
          //       //   mainAxisAlignment: MainAxisAlignment.end,
          //       //   crossAxisAlignment: CrossAxisAlignment.end,
          //       //   children: [

          //       //   ],
          //       // ),
          //     ],
          //   ),
          // ),
          Positioned(
            // top: 50,
            top: 200,
            bottom: 0, // Adjust this value for more/less overlap
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                height: Get.height,
                decoration: BoxDecoration(
                  // color: Colors.deepPurple.shade700,
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // boxShadow: [
                        //   BoxShadow(color: Colors.black12, blurRadius: 10),
                        // ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/image/bank_image.png",
                          // height: 250,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quick Action',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 10),
                    Gap(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: detailContainer(
                            context,
                            "Transfer\nMoney",
                            "assets/image/send.png",
                          ),
                        ),

                        Flexible(
                          child: detailContainer(
                            context,
                            "Pay\nBills",
                            "assets/image/receipt.png",
                          ),
                        ),

                        Flexible(
                          child: detailContainer(
                            context,
                            "My\nCards",
                            "assets/image/credit_card.png",
                          ),
                        ),

                        Flexible(
                          child: detailContainer(
                            context,
                            "Loans",
                            "assets/image/loan.png",
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Have a Query?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        queryCard(context),
                      ],
                    ).paddingSymmetric(horizontal: 10),
                    Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [virtualDebitCardBanner(context)],
                    ).paddingSymmetric(horizontal: 10),
                    // SizedBox(
                    //   width: 250,
                    //   child: Lottie.asset(
                    //     'assets/lottie/waving_man.json', // apna lottie path yaha daalo
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    // Text("Hi $username\n Do you have any query?"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   elevation: 4,
      //   shape: const CircleBorder(),
      //   onPressed: () => Get.to(() => StepsScreen()),
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget detailContainer(
    BuildContext context,
    String title,
    String assetImagePath,
  ) {
    return Container(
      width: 90,
      height: 115,
      // width: 110,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F4FA),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetImagePath,
            height: 25,
            width: 30,
            // fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget queryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF6C3EF4),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "We're here to help you!",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "Your banking assistant for accounts and more",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Gap(5),

          OutlinedButton.icon(
            onPressed: () {
              Get.to(() => StepsScreen());
            },
            icon: const Icon(Icons.chat_bubble, color: Color(0xFF6C3EF4)),
            label: const Text(
              "Ask Query",
              style: TextStyle(
                color: Color(0xFF6C3EF4),
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              side: const BorderSide(color: Color(0xFF6C3EF4)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget virtualDebitCardBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          // Card Image
          Container(
            width: 110,
            height: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4F23D7), Color(0xFF6C3EF4)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Positioned(
                  top: 14,
                  left: 12,
                  child: Icon(
                    Icons.sim_card,
                    color: Color(0xFFFFD54F),
                    size: 20,
                  ),
                ),
                const Positioned(
                  top: 12,
                  right: 12,
                  child: Icon(Icons.wifi, color: Colors.white, size: 18),
                ),
                Positioned(
                  bottom: 18,
                  left: 12,
                  child: Text(
                    "****  ****  ****  4582",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.9),
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -5,
                  right: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "VISA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Get your Virtual Debit Card",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                // SizedBox(height: 6),
                Text(
                  "For secure online payments",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C3EF4), Color(0xFF4F23D7)],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              "Get Now",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
