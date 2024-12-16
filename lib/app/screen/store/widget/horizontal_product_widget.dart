import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../models/categories_model.dart';
import '../../../services/api_services.dart';

class HorizontalProductWidget extends StatelessWidget {
  final String sectionTitle;
  final List<String> imgList;
  final List<String> titleList;
  final List<String> weightList;
  final List<String> priceList;
  final Function() seeAllTap;
  final Function(int? i) productTap;
  final bool? isNetworkImage;
  final int? index;
  final HomeScreenController? homescreencontroller ;
 final List<Product>? products;

  const HorizontalProductWidget({
    Key? key,
    required this.sectionTitle,
    required this.imgList,
    required this.titleList,
    required this.weightList,
    required this.priceList,
    required this.seeAllTap,
    required this.productTap,
    this.isNetworkImage, this.index,  this.homescreencontroller, this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index! % 2 == 0?Colors.white: Color(0xFFF4F7EE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        clipBehavior: Clip.hardEdge,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10)),
                        child: Image.asset(
                          Images.icSeeds,
                        )),
                    sizedBoxW5(),
                    Text(
                      sectionTitle,
                      style: poppinsMedium.copyWith(
                        fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: seeAllTap,
                    child: Text(
                      'SEE ALL',
                      style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).hintColor),
                    ))
              ],
            ),
          ),
          sizedBox10(),
          imgList.isEmpty
              ? SizedBox(
              height: 240,
              child: const Center(child: Text("No products available")))
              :
          SizedBox(
            height: 245, // Adjust the height to fit your items.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imgList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: (){ productTap(i);},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16,left: 16,bottom: 10),
                    // Add spacing between items
                    child: Container(
                      width: 160, // Adjust width to your needs
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .hintColor
                                .withOpacity(0.10),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                        border: Border.all(
                          width: 1,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.10),
                        ),
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSize10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: isNetworkImage ?? false
                                ? Image.network(
                              '${ApiService().imageBaseUrlMain}${imgList[i]}',
                                    width: 100,
                                    height: 100,
                                  )
                                : Image.asset(
                                    imgList[i],
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                          sizedBox10(),
                          Text(
                            titleList[i],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.80),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Flexible(
                          //       child: Text(
                          //         weightList[i],
                          //         overflow: TextOverflow.ellipsis,
                          //         style: poppinsRegular.copyWith(
                          //           fontSize: Dimensions.fontSize12,
                          //           color: Theme.of(context).hintColor,
                          //         ),
                          //       ),
                          //     ),
                          //     Flexible(
                          //       child: Text(
                          //         '₹ ${priceList[i]}',
                          //         overflow: TextOverflow.ellipsis,
                          //         style: poppinsBold.copyWith(
                          //           fontSize: Dimensions.fontSize18,
                          //           color: Theme.of(context).primaryColor,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                         Spacer(),
                          CustomButtonWidget(
                            height: 30,
                            isBold: false,
                            fontSize: Dimensions.fontSize14,
                            buttonText: "Add to Cart",
                            transparent: true,
                            onPressed: () {
                              // Add your onPressed functionality here
                              homescreencontroller!.addToCart(homescreencontroller!,products![i].id.toString());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
