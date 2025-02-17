import 'package:anuplal/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../services/api_services.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/profile_components.dart';
import '../MyOrdersScreen/my_orders.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(125),
          child: CustomAppBar(
            title: 'Account',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 165,
                  child: ProfileComponents(
                    title: const ['Account Details',],
                    components: const [
                      'Profile',
                      'My Orders',
                    ],
                    componentsFunctions: [
                          () {
                        Get.toNamed(RouteHelper.getProfileRoute());
                      },
                          () {
                        Get.toNamed(RouteHelper.getmyOrdersRoute());
                      },

                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 165,
                  child: ProfileComponents(
                    title: const ['Know About Us',],
                    components: const [
                      'About Us',
                      'Contact Us',
                    ],
                    componentsFunctions: [
                          () {
                        Get.toNamed(RouteHelper.aboutUs);
                      },
                          () {
                        Get.toNamed(RouteHelper.getContactUsRoute());
                      },

                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: ProfileComponents(
                    title: const ['Links'],
                    components: const [
                      'Privacy Policy',
                      'Terms & Conditions',
                    ],
                    componentsFunctions: [
                          () {
                        Get.toNamed(RouteHelper.privacyPolicy);
                      },
                          () {
                        Get.toNamed(RouteHelper.termsAndCondition);
                      },
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          // Add action here
                        },
                        child: Image.asset("assets/images/Facebook.png",scale: 3,)),
                    GestureDetector(
                        onTap: () {
                          // Add action here
                        },
                        child: Image.asset("assets/images/Instagram.png",scale: 3,)),
                    GestureDetector(
                        onTap: () {
                          // Add action here
                        },
                        child: Image.asset("assets/images/Twitter.png",scale: 3,)),
                  ],
                ),
              ],
            ),
          ),

        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: CustomButtonWidget(buttonText: 'Logout',
              color: Colors.red,
              borderSideColor: Colors.red,
              onPressed: () async {
                await ApiService().logOutApi();
              },),
          ),
        ),
      ),
    );
  }

  InkWell buildColumn({
    required Function() tap,
    required String title,
  }) {
    return InkWell(
      onTap: tap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsRegular.copyWith(
              fontSize: Dimensions.fontSize20,
            ),
          ),
          sizedBox4(),
          Divider(),
        ],
      ),
    );
  }
}
