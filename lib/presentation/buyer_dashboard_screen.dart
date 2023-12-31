import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 144,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse1,
                                height: 82,
                                width: 131,
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse2,
                                height: 53,
                                width: 200,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 25),
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse3,
                                height: 96,
                                width: 118,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse4,
                                height: 73,
                                width: 178,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgJagokisanremovebgpreview,
                                height: 97,
                                width: 104,
                                radius: BorderRadius.circular(48),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 17, top: 15, right: 7),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/view_product_page_user_screen');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Transparent background
                                    shadowColor:
                                        Colors.transparent, // No shadow
                                    side: BorderSide(
                                        width: 1,
                                        color:
                                            Color(0xFF255B20)), // Border color
                                    elevation: 0, // No elevation
                                  ),
                                  child: Column(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.barley,
                                        height: 150,
                                        width: 150,
                                      ),
                                      SizedBox(
                                          height:
                                              8), // Gap between image and text
                                      Text("PRODUCTS",
                                          style: TextStyle(
                                              color: Color(0xFF255B20)))
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/view_current_bidding_screen');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Transparent background
                                    shadowColor:
                                        Colors.transparent, // No shadow
                                    side: BorderSide(
                                        width: 1,
                                        color:
                                            Color(0xFF255B20)), // Border color
                                    elevation: 0, // No elevation
                                  ),
                                  child: Column(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.auction,
                                        height: 150,
                                        width: 150,
                                      ),
                                      SizedBox(
                                          height:
                                              8), // Gap between image and text
                                      Text("BIDDING HISTORY",
                                          style: TextStyle(
                                              color: Color(0xFF255B20)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/payment_user_screen');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Transparent background
                                    shadowColor:
                                        Colors.transparent, // No shadow
                                    side: BorderSide(
                                        width: 1,
                                        color:
                                            Color(0xFF255B20)), // Border color
                                    elevation: 0, // No elevation
                                  ),
                                  child: Column(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.receiveCash,
                                        height: 150,
                                        width: 150,
                                      ),
                                      SizedBox(
                                          height:
                                              8), // Gap between image and text
                                      Text("PAYMENT HISTORY",
                                          style: TextStyle(
                                              color: Color(0xFF255B20)))
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/profile_update_screen');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Transparent background
                                    shadowColor:
                                        Colors.transparent, // No shadow
                                    side: BorderSide(
                                        width: 1,
                                        color:
                                            Color(0xFF255B20)), // Border color
                                    elevation: 0, // No elevation
                                  ),
                                  child: Column(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.account,
                                        height: 150,
                                        width: 150,
                                      ),
                                      SizedBox(
                                          height:
                                              8), // Gap between image and text
                                      Text("MY PROFILE",
                                          style: TextStyle(
                                              color: Color(0xFF255B20)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {},
        ),
      ),
    );
  }
}
