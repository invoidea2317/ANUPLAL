import 'package:anuplal/app/screen/store/widget/horizontal_product_widget.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/store_controller.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api_services.dart';
import '../../widgets/custom_buttons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class NearestStore extends StatefulWidget {
  const NearestStore({super.key});

  @override
  State<NearestStore> createState() => _NearestStoreState();
}

class _NearestStoreState extends State<NearestStore> {
  StoreController storeController = Get.put(StoreController());
  HomeScreenController  homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, you may want to handle this
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    storeController.fetchNearestCategories(
        lat: position.latitude.toString(), long: position.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      debugPrint(
          "storeController.nearest ${storeController.nearestShop}");
      if (storeController.nearestShop.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: CustomAppBar(
              isBackButtonExist: true,
              title: 'Nearest Store',
              menuWidget: Row(
                children: [
                  CustomNotificationButton(
                    tap: () {},
                  ),
                  sizedBoxW10(),
                  CustomCartButton(
                    tap: () {},
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [

                sizedBoxDefault(),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal:16.0),
                 child: Container(
                    width: double.infinity,
                   padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 8.0),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.white,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.5),
                         spreadRadius: 5,
                         blurRadius: 4,
                         offset: const Offset(0, 3), // changes position of shadow
                       ),
                     ],
                   ),
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: Container(
                           width: 324,
                           height: 116.90,
                           decoration:  BoxDecoration(
                             image: DecorationImage(
                               image:
                               NetworkImage(ApiService().imageBaseUrlMain + storeController.nearestShop[0].media!.src),
                               fit: BoxFit.cover,
                             ),
                           ),
                         ),
                       ),
                       sizedBoxDefault(),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: SizedBox(
                           width: double.infinity,
                           child: Text(
                             storeController.nearestShop[0].name ?? "",
                             style: TextStyle(
                               color: Colors.black,
                               fontSize: 12,
                               fontFamily: 'Poppins',
                               fontWeight: FontWeight.bold,
                               height: 0,
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 2,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: SizedBox(
                           width: double.infinity,
                           child: Text(
                             storeController.nearestShop[0].description ?? "",
                             style: TextStyle(
                               color: Colors.black.withOpacity(0.5),
                               fontSize: 12,
                               fontFamily: 'Poppins',
                               fontWeight: FontWeight.w400,
                               height: 0,
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 2,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: SizedBox(
                           width: double.infinity,
                           child: RichText(
                             text: TextSpan(
                               children: [
                                 TextSpan(
                                   text: "Address: ",
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 12,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.bold,
                                     height: 1.5, // Adjust line height if necessary
                                   ),
                                 ),
                                 TextSpan(
                                   text: storeController.nearestShop[0].address,
                                   style: TextStyle(
                                     color: Colors.black.withOpacity(0.5),
                                     // Different color for address value
                                     fontSize: 12,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w400,
                                     height: 1.5, // Adjust line height if necessary
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),

                       sizedBoxDefault(),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
                         child: Container(
                           width: double.infinity,
                           height: 46,
                           decoration: ShapeDecoration(
                             gradient: const LinearGradient(
                               begin: Alignment(1.00, -0.02),
                               end: Alignment(-1, 0.02),
                               colors: [Color(0xFF739A2B), Color(0xFF4C5829)],
                             ),
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5)),
                           ),
                           child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.transparent,
                               elevation: 0,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5),
                               ),
                             ),
                             onPressed: () {},
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(
                                   Icons.phone,
                                   color: Colors.white,
                                 ),
                                 SizedBox(
                                   width: 10,
                                 ),
                                 Text(
                                   'Contact Store',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 16,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w400,
                                     height: 0,
                                   ),
                                 )
                               ],
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
                sizedBoxDefault(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Products',
                        style: TextStyle(
                          color: Color(0xFF4C5829),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxDefault(),
                for (int i = 0; i < storeController.nearestShop.length; i++)
                  GetBuilder<HomeScreenController>(
                    builder: (homeScreenController) => HorizontalProductWidget(
                      homescreencontroller: homeScreenController,
                      products: storeController
                          .nearestShop[i].products,
                      index: i,
                      sectionTitle: storeController.nearestShop[i].name ?? '',
                      imgList: storeController.nearestShop[i].products!.map((e) => e.media!.src).toList(),
                      titleList: storeController.nearestShop[i].products!.map((e) => e.name).toList(),
                      weightList: [],
                      priceList: storeController.nearestShop[i].products!.map((e) => e.price.toString()).toList(),
                      productTap: (index) {
                        homeScreenController.fetchParticularDetails(homeScreenController, storeController
                            .nearestShop[i].products![index??0].id.toString(), storeController
                            .nearestShop[i].id.toString());
                        Get.toNamed(RouteHelper.getProductDetailRoute());
                        Get.toNamed(RouteHelper.getProductDetailRoute());
                      },
                      isNetworkImage: true,
                      seeAllTap: () async {
                        dynamic val =
                            await homeScreenController.fetchParticularCategory(
                                homeScreenController,
                                storeController.categories[i].id.toString());
                        debugPrint("val $val");
                        if (val) {
                          Get.toNamed(
                            RouteHelper.categoryProducts,
                          );
                        } else {}
                      },
                    ),
                  ),
                sizedBox100(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
