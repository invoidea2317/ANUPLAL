import 'package:anuplal/app/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../../controller/home_screen_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_cart_widget.dart';
import 'package:get/get.dart';

import '../../widgets/payment_Selection.dart';
import '../../widgets/place_order_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  ApiService apiService = ApiService();
  bool isOnlinePaymentSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      homeScreenController.addToCartListing([]);
      apiService.FetchcartListing(homeScreenController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeScreenController>(builder: (homeScreenController) {
        if (homeScreenController.shopModel.isEmpty) {
          return const Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(125),
              child: CustomAppBar(
                title: 'Cart',
                isBackButtonExist: true,
              ),
            ),
            body: Center(
              child: Text("No items in cart"),
            ),
          );
        }
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: CustomAppBar(
              title: 'Cart',
              isBackButtonExist: true,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeScreenController.shopModel[0].products!.length,
                  itemBuilder: (context, index) {
                    debugPrint(homeScreenController
                        .shopModel[0].products![index].price
                        .toString());
                    return Column(
                      children: [
                        CartItemContainer(
                          imagePath:
                          '${ApiService().imageBaseUrl}${homeScreenController
                              .shopModel[0].products![index].thumbnail}',
                          productName: homeScreenController
                              .shopModel[0].products![index].name,
                          quantity: homeScreenController
                              .shopModel[0].products![index].quantity,
                          price: homeScreenController
                              .shopModel[0].products![index].price,
                          id: homeScreenController.shopModel[0].products![index]
                              .id
                              .toString(),
                          homeScreenController: homeScreenController,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
                Container(
                  height: 150,
                  child: PaymentOptionsScreen(
                    onPaymentOptionSelected: (bool isCodSelected,
                        bool isPayOnlineSelected) {
                      setState(() {
                        isOnlinePaymentSelected = isPayOnlineSelected;
                      });
                    },

                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: PlaceOrderButton(
                totalAmountValue: homeScreenController.totalPrice.toString(),
                shopModel: homeScreenController.shopModel,
                homeScreenController: homeScreenController,
                isOnlinePaymentSelected: isOnlinePaymentSelected,
              ),
            ),
          ),
        );
      }),
    );
  }
}
