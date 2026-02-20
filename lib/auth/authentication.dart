import 'package:fintrix/screen/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    isPhone(maxWidth) {
      if (maxWidth < 600) {
        // Display for small screens (e.g., phones)
        return true;
      } else {
        // Display for larger screens (e.g., tablets, desktops)
        return false;
      }
    }

    return
    // Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   body:
    context.isPhone && Get.height > 600
        ? Container(
            color: Colors.black,
            child: GetNavigator(
              // key: Get.nestedKey(authKey),
              // child: Container(
              //     color: Colors.brown,
              //   ),
              pages: const [
                MaterialPage(
                  key: ValueKey('FirstScreen'),
                  child: FirstScreen(),
                ),
              ],
            ),
          )
        : Container(
            // color: AppColors.baseColor,
            child: Center(
              child: Column(
                children: [
                  // Container(
                  //   height: 60,
                  //   width: double.infinity,
                  //   color: Colors.black,
                  // ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // if (Get.width > 800)
                        //   SizedBox(
                        //     width: 200,
                        //     child: ClipRRect(
                        //       //  constraints: const BoxConstraints(maxHeight: 600),
                        //       borderRadius: BorderRadius.circular(22),
                        //       child: ConstrainedBox(
                        //           constraints:
                        //               const BoxConstraints(maxHeight: 600),
                        //           child: const CustomDrawer()),
                        //     ).paddingSymmetric(vertical: 44, horizontal: 10),
                        //   ),
                        Flexible(
                          child: Container(
                            height: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: GetNavigator(
                              // key: Get.nestedKey(),
                              // key: Get.nestedKey(authNavigationKey),
                              pages: const [
                                MaterialPage(
                                  key: ValueKey('FirstScreen'),
                                  child: FirstScreen(),
                                ),
                              ],
                              // onGenerateInitialRoutes: (navigator, initialRoute) =>,
                              onPopPage: (route, result) =>
                                  route.didPop(result),
                              // key: const Key("1"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
    // ,
    // );
  }
}
