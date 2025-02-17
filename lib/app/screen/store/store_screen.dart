
import 'package:anuplal/app/screen/store/widget/horizontal_product_widget.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/store_controller.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/categories_model.dart';
import '../../widgets/custom_buttons.dart';
import 'package:geolocator/geolocator.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
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
      if (storeController.nearestShop.isEmpty) {
        return SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(125),
                child: CustomAppBar(
                  title: 'Stores',
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
              body: const Center(child: CircularProgressIndicator())),
        );
      }
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: CustomAppBar(
              title: 'Stores',
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
                for (int i = 0;
                    i < storeController.nearestShop.length;
                    i++)
                  GetBuilder<HomeScreenController>(
                    builder: (homeScreenController) => HorizontalProductWidget(
                      products: storeController
                          .nearestShop[i].products,
                      homescreencontroller: homeScreenController,
                      index: i,
                      sectionTitle:
                          storeController.nearestShop[i].name ?? "",
                      imgList: storeController
                          .nearestShop[i].products
                          !.map((e) => (e.media ?? Media(id: 0, type: '', src: '')).src)
                          .toList(),
                      titleList: storeController
                          .nearestShop[i].products!
                          .map((e) => e.name)
                          .toList(),
                      weightList: [],
                      priceList: storeController
                          .nearestShop[i].products!
                          .map((e) => e.price.toString())
                          .toList(),
                      productTap: (index) {
                        homeScreenController.fetchParticularDetails(homeScreenController, storeController
                            .nearestShop[i].products![index??0].id.toString(),storeController
                            .nearestShop[i].id.toString());
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
                // sizedBox100()
              ],
            ),
          ),
        ),
      );
    });
  }
}
