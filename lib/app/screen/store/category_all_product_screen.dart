import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/app/widgets/custom_product_widget.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../controller/home_screen_controller.dart';
import '../../services/api_services.dart';

class CategoryAllProductScreen extends StatelessWidget {
  CategoryAllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (homeScreenController) {
      if (homeScreenController.particularCategoriesproducts.isEmpty) {
        return Scaffold(
            appBar: CustomAppBar(
                title: homeScreenController.categoryName,
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
                isBackButtonExist: true),
            body: const Center(child: Text("No Products Found")));
      }

      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: CustomAppBar(
              isBackButtonExist: true,
              title: homeScreenController.categoryName,
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
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 240
                  // childAspectRatio: 0.7,
                  ),
              itemCount:
                  homeScreenController.particularCategoriesproducts.length,
              itemBuilder: (context, i) {
                return CustomProductWidget(
                    productId:
                        homeScreenController.particularCategoriesproducts[i].id,
                    productTap: () {
                      homeScreenController.fetchParticularDetails(
                        homeScreenController,
                        homeScreenController.particularCategoriesproducts[i].id
                            .toString(),
                        homeScreenController.particularCategoriesproducts[i]
                            .shop.id
                            .toString(),
                      );
                      Get.toNamed(RouteHelper.getProductDetailRoute());
                    },
                    image:
                        "${ApiService().imageBaseUrl}${homeScreenController.particularCategoriesproducts[i].thumbnail}",
                    title: homeScreenController
                        .particularCategoriesproducts[i].name,
                    weight: homeScreenController
                        .particularCategoriesproducts[i].quantity
                        .toString(),
                    price: homeScreenController
                        .particularCategoriesproducts[i].price
                        .toString(),
                    addCartTap: () {
                      homeScreenController.addToCart(
                          homeScreenController,
                          homeScreenController
                              .particularCategoriesproducts[i].id
                              .toString());
                    });
              },
            ),
          ),
        ),
      );
    });
  }
}
