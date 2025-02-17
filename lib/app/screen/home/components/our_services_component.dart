import 'package:anuplal/app/screen/dashboard/dashboard_screen.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../NearestStore/nearest_store.dart'; // Assuming you are using GetX for navigation

class OurServicesComponent extends StatelessWidget {
  OurServicesComponent({super.key});

  final List<String> img = [
    Images.icStoreCategory,
    Images.icDoctorCategory,
    Images.icCommunityCategory,
    Images.icNearestStoreCategory,
    Images.icSoilCategory,
  ];

  final List<String> title = [
    'Store',
    'Crop Doctor',
    'Farmer Community',
    'Nearest Store',
    'Soil Testing',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Text(
            'Our Services',
            style: poppinsRegular.copyWith(
              fontSize: Dimensions.fontSize14,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        sizedBox10(),
        SizedBox(
          height: 120,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: img.length,
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () {
                  // Add tap actions based on the index
                  switch (i) {
                    case 0:
                    // Navigate to Store
                      Get.offAll(()=> DashboardScreen(pageIndex: 2));
                      break;
                    case 1:
                    // Navigate to Crop Doctor
                      Get.toNamed(RouteHelper.getCropDoctorRoute());
                      break;
                    case 2:
                      Get.to(()=> DashboardScreen(pageIndex: 1));
                      break;
                    case 3:
                    // Navigate to Nearest Store
                      Get.offAll(const NearestStore());
                      break;
                    case 4:
                    // Navigate to Soil Testing
                      Get.toNamed('/soilTesting');
                      break;
                    default:
                    // Default case if needed
                      break;
                  }
                },
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                        ),
                        child: Image.asset(img[i]),
                      ),
                      sizedBox4(),
                      Text(
                        title[i],
                        textAlign: TextAlign.center,
                        style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSize12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
