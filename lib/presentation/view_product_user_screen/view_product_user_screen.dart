import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_search_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewPageUserScreen extends StatefulWidget {
  ViewPageUserScreen({Key? key}) : super(key: key);

  @override
  _ViewUserState createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewPageUserScreen> {
  List<Map<String, dynamic>> prodList = [];
  late http.Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final List<Map<String, dynamic>>? fetchedProdList =
        await getAllProducts(context);
    if (fetchedProdList != null) {
      setState(() {
        prodList = fetchedProdList;
      });
    }
  }

  List<Map<String, dynamic>> filterProducts(String searchText) {
    return prodList.where((product) {
      final productName = product['productName'].toLowerCase();
      return productName.contains(searchText.toLowerCase());
    }).toList();
  }

  Future<List<Map<String, dynamic>>?> getAllProducts(
      BuildContext context) async {
    try {
      final response = await client.get(
        Uri.parse('http://172.28.14.76:8080/product/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Explicitly cast the result to the correct type
        final List<Map<String, dynamic>> prodList =
            (json.decode(response.body) as List)
                .map((item) => item as Map<String, dynamic>)
                .toList();
        return prodList;
      } else {
        // Handle error responses here
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch purchase requisitions');
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      print('Error: $e');
      return null;
    }
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 144.v,
                        width: double.maxFinite,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse1,
                                height: 82.v,
                                width: 131.h,
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse2,
                                height: 53.v,
                                width: 200.h,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 25.h),
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse3,
                                height: 96.v,
                                width: 118.h,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse4,
                                height: 73.v,
                                width: 178.h,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgJagokisanremovebgpreview,
                                height: 97.v,
                                width: 104.h,
                                radius: BorderRadius.circular(48.h),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 17.h,
                          top: 15.v,
                          right: 7.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgVolume,
                              height: 35.v,
                              width: 40.h,
                              margin: EdgeInsets.only(
                                top: 10.v,
                                bottom: 7.v,
                              ),
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    AppRoutes.buyerDashboardScreen);
                              },
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 27.h,
                                  right: 27.h,
                                  top: 10.v,
                                ),
                                child: Text(
                                  "Products",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomSearchView(
                        margin: EdgeInsets.only(
                            left: 40.h, top: 15.v, right: 33.h, bottom: 15.h),
                        controller: searchController,
                        hintText: "Search here",
                        hintStyle: CustomTextStyles.titleBlack,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(14.h, 10.v, 5.h, 10.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgSearch,
                            color: Colors.black,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 41.v,
                        ),
                        suffix: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 8.v, 15.h, 8.v),
                          child: GestureDetector(
                            onTap: () {
                              searchController.clear(); // Clear the search text
                            },
                            child: CustomImageView(
                              svgPath: ImageConstant.imgClose,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: 41.v,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.fromLTRB(30.h, 8.v, 30.h, 8.v),
                        child: Column(
                          children: [
                            SizedBox(height: 5.v),
                            Builder(
                              builder: (context) {
                                final filteredProducts =
                                    filterProducts(searchController.text);
                                return ListView.builder(
                                  itemCount:
                                      filterProducts(searchController.text)
                                          .length,
                                  shrinkWrap: true,
                                  itemExtent: 250,
                                  // itemCount: prodList.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> prod =
                                        filteredProducts[index];
                                    String productName = prod['productName'] ??
                                        "Unknown Product";
                                    String farmerName =
                                        prod['farmerName'] ?? "Unknown";
                                    String quantity =
                                        prod['quantity'].toString();
                                    print(quantity);
                                    String amountPerkg =
                                        prod['amountPerkg'].toString() ??
                                            "Pending";
                                    String expiryDate = prod['expiryDate']
                                        .toString()
                                        .substring(0, 10);
                                    String photo = prod['photo'];

                                    List<int> bytes = base64Decode(photo);
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              10), // Add vertical spacing between items
                                      padding: EdgeInsets.all(10),

                                      decoration:
                                          AppDecoration.outlineGray.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder18,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Opacity(
                                            opacity: 0.9,
                                            child: Image.memory(
                                              Uint8List.fromList(
                                                  bytes), // Convert bytes to Uint8List
                                              width:
                                                  150, // Set the image width as needed
                                              height: 150,

                                              // Set the image height as needed
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 2.v),
                                            child: Column(
                                              children: [
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: Text(
                                                    "Farmer : $farmerName",
                                                    style: theme
                                                        .textTheme.labelLarge
                                                        ?.copyWith(
                                                      fontWeight: FontWeight
                                                          .bold, // Make text bold
                                                      fontSize:
                                                          15.0, // Increase font size
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 12.v),
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: Text(
                                                    "$productName",
                                                    style: theme
                                                        .textTheme.labelLarge
                                                        ?.copyWith(
                                                      fontWeight: FontWeight
                                                          .bold, // Make text bold
                                                      fontSize:
                                                          15.0, // Increase font size
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5.v),
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: SizedBox(
                                                    width: 89.h,
                                                    child: Text(
                                                      "$quantity kg\nPrice per kg:-",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.labelLarge
                                                          ?.copyWith(
                                                        fontWeight: FontWeight
                                                            .bold, // Make text bold
                                                        fontSize: 15.0,
                                                        // Increase font size
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: SizedBox(
                                                    width: 89.h,
                                                    child: Text(
                                                      "Rs.$amountPerkg.00",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.labelLarge
                                                          ?.copyWith(
                                                        fontWeight: FontWeight
                                                            .bold, // Make text bold
                                                        fontSize:
                                                            15.0, // Increase font size
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: SizedBox(
                                                    width: 89.h,
                                                    child: Text(
                                                      "Expiry date:-",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.labelLarge
                                                          ?.copyWith(
                                                        fontWeight: FontWeight
                                                            .bold, // Make text bold
                                                        fontSize:
                                                            15.0, // Increase font size
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: SizedBox(
                                                    width: 89.h,
                                                    child: Text(
                                                      "$expiryDate",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.labelLarge
                                                          ?.copyWith(
                                                        fontWeight: FontWeight
                                                            .bold, // Make text bold
                                                        fontSize:
                                                            15.0, // Increase font size
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10.h,
                                                      top: 6.v,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        CustomElevatedButton(
                                                          width: 68.h,
                                                          text: "Bid",
                                                          onTap: () {
                                                            navigate(
                                                                farmerName,
                                                                productName,
                                                                quantity);
                                                          },
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 14.v),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            // Call the getFarmerContact function to retrieve the contact value
                                                            String
                                                                contactValue =
                                                                await getFarmerContact(
                                                                    farmerName);

                                                            // Show a modal dialog
// Show a modal dialog
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Dialog(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Positioned(
                                                                          top:
                                                                              0.0,
                                                                          right:
                                                                              0.0,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pop(); // Close the dialog
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.close,
                                                                              size: 30.0,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Center(
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              // Display the image
                                                                              CustomImageView(
                                                                                margin: EdgeInsets.only(top: 14.v),
                                                                                imagePath: ImageConstant.imgCall,
                                                                                height: 100.adaptSize,
                                                                                width: 100.adaptSize,
                                                                              ),
                                                                              // Display the farmer name with larger font size and color
                                                                              Container(
                                                                                margin: EdgeInsets.only(top: 10),
                                                                                child: Text(
                                                                                  farmerName,
                                                                                  style: TextStyle(
                                                                                    fontSize: 24,
                                                                                    color: Color(0xFF255B20),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // Display the contact value with larger font size and color
                                                                              Container(
                                                                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                                                                child: Text(
                                                                                  contactValue,
                                                                                  style: TextStyle(
                                                                                    fontSize: 24,
                                                                                    color: Color(0xFF255B20),
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
                                                              },
                                                            );
                                                          },
                                                          child: Opacity(
                                                            opacity: 0.9,
                                                            child:
                                                                CustomImageView(
                                                              svgPath:
                                                                  ImageConstant
                                                                      .imgUser,
                                                              height:
                                                                  34.adaptSize,
                                                              width:
                                                                  34.adaptSize,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          20.h,
                                                                      top:
                                                                          14.v),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
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

  Future<String> getFarmerContact(String farmerName) async {
    final response = await http.get(
      Uri.parse('http://172.28.14.76:8080/user/get-contact/$farmerName'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final int contact = data['contact'] as int;
      final String contactString = contact.toString();
      return contactString;
    } else {
      throw Exception('Failed to get farmer contact');
    }
  }

  Future<void> navigate(
    String farmerName,
    String productName,
    String quantity,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('farmerName', farmerName);
    await prefs.setString('productName', productName);
    await prefs.setString('quantity', quantity);

    Navigator.of(context).pushReplacementNamed('/request_bidding_screen');
  }
}
