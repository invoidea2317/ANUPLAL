import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomProductWidget extends StatelessWidget {
  final Function() productTap;
  final String image;
  final String title;
  final String weight;
  final String price;
  final Function() addCartTap;
  const CustomProductWidget({super.key, required this.productTap, required this.image, required this.title, required this.weight, required this.price, required this.addCartTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: productTap,
      child: Container(
        width: 160, // Adjust width to your needs
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
                image,
                width: 100,
                height: 100,
              ),
            ),
            sizedBox10(),
            Text(
              title,
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
                    "Rs. $weight",
                    overflow: TextOverflow.ellipsis,
                    style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSize12,
                      color: Theme.of(context).hintColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                Text(
                  price,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsBold.copyWith(
                    fontSize: Dimensions.fontSize12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
        Spacer(),
            CustomButtonWidget(
              height: 30,
              isBold: false,
              fontSize: Dimensions.fontSize14,
              buttonText: "Add to Cart",
              transparent: true,
              onPressed: addCartTap,
            ),
          ],
        ),
      ),
    );;
  }
}
