import 'package:anuplal/app/screen/home/components/home_category_component.dart';
import 'package:anuplal/app/screen/home/components/our_services_component.dart';
import 'package:anuplal/app/screen/home/components/recommended_product.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controller/store_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/sizeboxes.dart';
import '../../models/product_model.dart';
import '../../services/api_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<PopularProduct> products = [];
  String address = '';

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final TextEditingController filter = TextEditingController();
  StoreController storeController = Get.put(StoreController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeScreenController.fetchProducts(homeScreenController);
      apiService.FetchcartListing(homeScreenController);
      _setInitialLocation();
    });
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
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        address =
        "${place.street}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (homeScreenController) {
      if (homeScreenController.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
            body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            Theme.of(context).disabledColor.withOpacity(0.07),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(Dimensions.radius30))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: Column(
                        children: [
                          sizedBox40(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Images.logo,
                                      width: 140,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_sharp,
                                          size: Dimensions.fontSize24,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Flexible(
                                          child: Text(
                                            address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: poppinsRegular.copyWith(
                                              fontSize: Dimensions.fontSize14,
                                              color: Theme.of(context)
                                                  .disabledColor
                                                  .withOpacity(0.60),
                                              decoration: TextDecoration
                                                  .underline, // Add underline
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteHelper.getCartRoute());
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            Images.icCart,
                                            height: 30,
                                            width: 30,
                                          ),
                                          GetBuilder<HomeScreenController>(
                                              builder: (homeScreenController) {
                                            return Visibility(
                                              visible: homeScreenController.shopModel[0].products!.isNotEmpty,
                                              child: Positioned(
                                                right: 0,
                                                left: 12,
                                                bottom: 5,
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  constraints: BoxConstraints(
                                                    minWidth: 5,
                                                    minHeight: 5,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      homeScreenController.shopModel[0].products!.length
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      )),
                                  sizedBoxW15(),
                                  Image.asset(
                                    Images.icNotification,
                                    height: Dimensions.fontSize24,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeDefault,
                        right: Dimensions.paddingSizeDefault,
                        bottom: Dimensions.paddingSize20),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSize5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5,
                                  color: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.10)),
                              color: Theme.of(context).cardColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Theme.of(context).hintColor,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Search",
                                        style: poppinsSemiBold.copyWith(
                                            fontSize: Dimensions.fontSize13,
                                            color: Theme.of(context)
                                                .hintColor), // Different color for "resend"
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  sizedBoxDefault(),
                  OurServicesComponent(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Image.asset(Images.imgHomeShopNowBanner),
                  ),
                  sizedBoxDefault(),
                  HomeCategoryComponent(
                    categoryProducts: homeScreenController.categories,
                    homeScreenController: homeScreenController,
                  ),
                  sizedBox30(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Image.asset(Images.imgHomeConsultNowBanner),
                  ),
                  sizedBoxDefault(),
                  RecommendedProduct(
                    products: homeScreenController.products,
                    homeScreenController: homeScreenController,
                  ),
                  sizedBoxDefault(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Image.asset(Images.imgHomeContactNowBanner),
                  ),
                  sizedBox100(),
                ],
              ),
            )
          ],
        )),
      );
    });
  }
}
