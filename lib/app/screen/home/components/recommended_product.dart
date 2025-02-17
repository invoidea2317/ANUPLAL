import 'dart:developer';

import 'package:anuplal/app/models/product_model.dart';
import 'package:anuplal/app/widgets/commontoast.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_services.dart';

class RecommendedProduct extends StatelessWidget {
  final HomeScreenController homeScreenController ;
  final List<PopularProduct> products;

  const RecommendedProduct({super.key, required this.products, required this.homeScreenController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Text(
              'RECOMMENDED PRODUCTS',
              style: TextStyle(
                color: Color(0xFF4C5829),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
          ),
          sizedBox10(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              mainAxisExtent: 240,
            ),
            itemCount: products.length, // Matches the number of products
            itemBuilder: (context, i) {

              final product = products[i];
             // debugPrint("${ApiService().imageBaseUrl}${product.thumbnail}");
              return GestureDetector(
                onTap: () {
                  homeScreenController.fetchParticularDetails(homeScreenController, product.id.toString(), product.shop.id.toString());
                  Get.toNamed(RouteHelper.getProductDetailRoute());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor.withOpacity(0.10),
                    ),
                  ),
                  padding: const EdgeInsets.all(Dimensions.paddingSize10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          "${ApiService().imageBaseUrl}${product.thumbnail}",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      sizedBox10(),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSize14,
                          color: Theme.of(context).disabledColor.withOpacity(0.80),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '₹ ${product.price}',
                              overflow: TextOverflow.ellipsis,

                              style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Theme.of(context).hintColor,
                                decoration: TextDecoration.lineThrough,
                              ),

                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '₹ ${product.discountPrice}',
                            overflow: TextOverflow.ellipsis,
                            style: poppinsBold.copyWith(
                              fontSize:Dimensions.fontSize12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      GetBuilder<HomeScreenController>(
                        builder: (controller) {
                          bool? added = false;
                          for (var element in controller.shopModel) {
                            (element.products ?? []).forEach((value){
                              log("${value.id}",name: "Cart Item Id");
                              log("${product.id}",name: "product Item Id");
                              if(value.id == product.id){
                                added = true;
                              }
                            });


                          }


                          return CustomButtonWidget(
                            height: 30,
                            isBold: false,
                            fontSize: Dimensions.fontSize14,
                            buttonText: (added ?? false)?"Added":"Add to Cart",
                            transparent: (added ?? false)?true:false,
                            onPressed: (added ?? false)?(){
                              CommonToast("Already added");
                            }:() {
                              // Add to cart action
                              homeScreenController.addToCart(homeScreenController,product.id.toString());
                            },
                          );
                        },

                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
