import 'package:anuplal/app/services/api_services.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/home_screen_controller.dart';
import '../models/cart_model.dart';
import 'package:get/get.dart';

class PlaceOrderButton extends StatelessWidget {
  final String totalAmountValue;
  final List<ShopModel> shopModel;
  final HomeScreenController homeScreenController;

  final bool isOnlinePaymentSelected;
   const PlaceOrderButton({super.key, required this.totalAmountValue, required this.shopModel, required this.homeScreenController, required  this.isOnlinePaymentSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            height: 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF4C5829)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Total:',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4000000059604645),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
               Spacer(),
                Text(
                  'Rs. $totalAmountValue',
                  style: TextStyle(
                    color: Color(0xFF4C5829),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        CustomButtonWidget(
            width: 136.89,
            height: 50,
            useGradient: true,
            gradient: LinearGradient(
              begin: Alignment(1.5, -0.02),
              end: Alignment(-1, 0.02),
              colors: [Color(0xFF4C5829),Color(0xFF739A2B), ],
            ),
            buttonText: "Order", onPressed: () {
              ApiService().bookOrder(shopModel: shopModel, paymentMethod: isOnlinePaymentSelected,totalAmountValue:totalAmountValue).then((value){
                Get.snackbar("Order Placed", "Your order has been placed successfully");
                ApiService().FetchcartListing(homeScreenController);
              });
        }),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
