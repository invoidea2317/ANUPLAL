import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/controller/product_controller.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../helper/route_helper.dart';
import '../../models/product_details.dart' as productDetails;
import '../../services/api_services.dart';
import 'dart:ffi' as ffi;

import 'dart:ui';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (homeScreenController) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: CustomAppBar(
              title: homeScreenController.productsDetails.name,
              isBackButtonExist: true,

              onBackPressed: () {
                Get.back();
                Future.delayed(const Duration(milliseconds: 50), () {
                  homeScreenController.setPopularProductsDetails(
                      productDetails.Product(
                    id: 0,
                    name: "",
                    description: "",
                    price: 0,
                    shortDescription: '',
                    discountPrice: 0,
                    discountPercentage: 0,
                    rating: 0,
                    totalReviews: 0,
                    totalSold: 0,
                    quantity: 0,
                    isFavorite: false,
                    thumbnails: [],
                    sizes: [],
                    colors: [],
                    brand: '',
                    shop: productDetails.ShopOfProduct(
                        id: 0,
                        name: "",
                        logo: "",
                        rating: 0,
                        estimatedDeliveryTime: "",
                        deliveryCharge: 0),
                  ));
                });
              },
              menuWidget: Row(
                children: [
                  CustomNotificationButton(
                    tap: () {},
                  ),
                  sizedBoxW10(),
                  CustomCartButton(
                    tap: () {

                    },
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: GetBuilder<ProductController>(builder: (productControl) {
              if (homeScreenController.productsDetails.id == 0) {
                return SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
              if (productControl.weightType.isEmpty) {
                homeScreenController.productsDetails.sizes.forEach((element) {
                  productControl.weightType.add(element.name);
                });
              } else {
                productControl.weightType.clear();
                homeScreenController.productsDetails.sizes.forEach((element) {
                  productControl.weightType.add(element.name);
                });
              }
              debugPrint(
                  "productControl.weightType ${productControl.weightType}");

              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: CarouselSlider(
                        items: homeScreenController.productsDetails.thumbnails
                            .map((e) => Image.network(
                          "${ApiService().imageBaseUrl}${e.thumbnail}",
                                  fit: BoxFit.cover,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          height: 400,
                          aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 8.0, // Space between chips
                          runSpacing: 8.0, // Space between lines of chips
                          children: List.generate(
                            productControl.weightType.length,
                            (index) {
                              final val = productControl.weightType[index];
                              final isSelected =
                                  productControl.weightString.contains(val);
                              return GestureDetector(
                                onTap: () {
                                  productControl.selectWeightString(val);
                                  productControl.setIndex(index);
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeDefault),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.10)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.radius5),
                                    border: Border.all(
                                      width: 0.5,
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      val,
                                      style: poppinsRegular.copyWith(
                                        color: isSelected
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .disabledColor
                                                .withOpacity(0.40),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Row(
                      children: [
                        Visibility(
                          visible: homeScreenController
                              .productsDetails.sizes.isNotEmpty,
                          child: Text(
                            homeScreenController.productsDetails.sizes.isNotEmpty
                                ? homeScreenController
                                    .productsDetails.sizes[0].price
                                    .toString()
                                : "",
                            style: TextStyle(
                              color: const Color(0xFF4C5829),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'About',
                            style: poppinsMedium.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                        ),
                        Text(
                          homeScreenController
                              .productsDetails.description,
                          style: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Container(
              height: 130,
              child: Column(
                children: [
                  CustomButtonWidget(
                    isBold: false,
                    buttonText: " Contact Store",
                    transparent: true,
                    icon: Icons.call,
                    onPressed: () {
                      // Get.toNamed(RouteHelper.getDashboardRoute());
                    },
                  ),
                  sizedBoxDefault(),
                  CustomButtonWidget(
                    isBold: false,
                    buttonText: " Add to Cart",
                    gradient: const LinearGradient(
                      colors: [Color(0xff739a2b), Color(0xff4c5829)],
                      stops: [0.2, 1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    useGradient: true,
                    onPressed: () {
                         homeScreenController.addToCart(homeScreenController,homeScreenController.productsDetails.id.toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
