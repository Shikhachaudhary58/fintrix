import 'package:fintrix/screen/query_detail.dart';
import 'package:fintrix/screen/working_day.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThankYouScreen extends StatelessWidget {
  final String address;
  final String? time;
  final dateRange = getWorkingDaysRange();
  final String? textMessage;
  final String? audioPath;
  final String? uploadedFilePath;

  ThankYouScreen({
    super.key,
    required this.address,
    this.time,
    this.textMessage,
    this.audioPath,
    this.uploadedFilePath,
  });

  String getMessage() {
    if (time != null && time!.isNotEmpty) {
      return "Thank you for your response.\n\n"
          "We are working on your query and will resolve it shortly. "
          "Our banking team will contact you within 3 working days $dateRange.\n\n"
          "Preferred Time: $time\n"
          "Address: $address\n\n"
          "We appreciate your time and patience.";
    } else {
      return "Thank you for your response.\n\n"
          "We are working on your query and will resolve it shortly. "
          "Our banking team will contact you within 3 working days.\n\n"
          "Address: $address\n\n"
          "We appreciate your time and patience.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// ✅ Success Icon
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 60,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ✅ Title
                    const Text(
                      "Request Submitted",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ✅ Message
                    Text(
                      getMessage(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ✅ Bottom Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(
                      () => QueryDetailScreen(
                        textMessage: textMessage,
                        audioPath: audioPath,
                        uploadedFilePath: uploadedFilePath,
                      ),
                    );
                    // Get.off(
                    //   QueryDetailScreen(
                    //     textMessage: textMessage,
                    //     audioPath: audioPath,
                    //     uploadedFilePath: uploadedFilePath,
                    //   ),
                    // );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => QueryDetailScreen(
                    //       textMessage: textMessage,
                    //       audioPath: audioPath,
                    //       uploadedFilePath: uploadedFilePath,
                    //     ),
                    //   ),
                    // );
                    // Navigate to Track Query Screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: const Text(
                    "Track Your Query",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
